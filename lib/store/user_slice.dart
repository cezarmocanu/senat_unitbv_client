import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:senat_unit_bv/constants/permission_schema.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:senat_unit_bv/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSlice extends ChangeNotifier {
  bool isAuth = false;
  User? currentUser;
  PermissionSchema permissions = PermissionSchema([]);

  Future<bool> logIn({required String email, required String password}) async {
    final response = await UserService.instance.login(email: email, password: password);

    if (response.statusCode == HttpStatus.created) {
      final prefs = await SharedPreferences.getInstance();
      final List<String> permissionsList = List<String>.from((json.decode(response.body)["permissions"]).map((value) => value as String));
      prefs.setString(SharedPrefsKeys.token, json.decode(response.body)["accessToken"]);
      prefs.setString(SharedPrefsKeys.role, jsonEncode(permissionsList));

      isAuth = true;
      permissions = PermissionSchema(permissionsList);

      await checkAuth();

      return true;
    }

    isAuth = false;
    return false;
  }

  Future<bool> checkAuth() async {
    final response = await UserService.instance.profile();
    final prefs = await SharedPreferences.getInstance();
    final List<String> permissionsList = List<String>.from((jsonDecode(prefs.getString(SharedPrefsKeys.role) ?? "[]") as List).map((value) => value));

    if (response.statusCode == HttpStatus.ok && permissionsList.isNotEmpty) {
      isAuth = true;
      currentUser = User.fromJson(json.decode(response.body));
      permissions = PermissionSchema(permissionsList);
      return true;
    }

    notifyListeners();
    isAuth = false;
    return false;
  }

  Future<bool> logOut() async {
    isAuth = false;
    permissions = PermissionSchema([]);
    currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPrefsKeys.token);
    prefs.remove(SharedPrefsKeys.role);
    return true;
  }
}
