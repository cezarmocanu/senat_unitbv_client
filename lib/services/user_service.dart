import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  UserService._internal();

  static final UserService instance = UserService._internal();

  Future<Response> profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.profile),
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

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await post(
        Uri.parse(API.login),
        body: json.encode({
          "email": email,
          "password": password,
        }),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      return response;
    } on Exception catch (_) {
      return Response("{}", 410);
    }
  }
}
