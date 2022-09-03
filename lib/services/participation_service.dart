import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticipationService {
  ParticipationService._internal();

  static final ParticipationService instance = ParticipationService._internal();

  Future<Response> joinMeeting(int meetingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await post(
        Uri.parse(API.joinMeeting(meetingId)),
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

  Future<Response> exitMeeting(int meetingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await put(
        Uri.parse(API.exitMeeting(meetingId)),
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

  Future<Response> participants(int meetingId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.participants(meetingId)),
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
}
