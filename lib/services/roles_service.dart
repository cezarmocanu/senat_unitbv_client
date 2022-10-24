import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RolesService {
  RolesService._internal();

  static final RolesService instance = RolesService._internal();

  Future<Response> getAllUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.rolesUsers),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token ?? ""}",
        },
      );

      return response;
    } on Exception catch (_) {
      return Response("{}", 410);
    }
  }

  Future<Response> getPermissions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.roleUsersPermissions),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token ?? ""}",
        },
      );

      return response;
    } on Exception catch (_) {
      return Response("{}", 410);
    }
  }

  Future<Response> updatePermission(User user, String permission, bool isEnabled) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await put(
        Uri.parse(API.updatePermissions),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token ?? ""}",
        },
        body: json.encode({
          "userId": user.id,
          "permission": permission,
          "isEnabled": isEnabled,
        }),
      );

      return response;
    } on Exception catch (_) {
      return Response("{}", 410);
    }
  }
}
