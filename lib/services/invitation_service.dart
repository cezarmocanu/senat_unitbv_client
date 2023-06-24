import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvitationService {
  InvitationService._internal();

  static final InvitationService instance = InvitationService._internal();

  Future<Response> invite(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await post(
        Uri.parse(API.invitation),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer ${token ?? ""}",
        },
        body: json.encode({'email': email}),
      );

      return response;
    } on Exception catch (_) {
      return Response("{}", 410);
    }
  }
}
