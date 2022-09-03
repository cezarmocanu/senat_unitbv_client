import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingService {
  MeetingService._internal();

  static final MeetingService instance = MeetingService._internal();

  Future<Response> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.meetings),
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

  Future<Response> getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.meetingsHistory),
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

  Future<Response> create(Map<String, dynamic> payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await post(
        Uri.parse(API.meetings),
        body: json.encode(payload),
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

  Future<Response> deleteMeeting(Meeting meeting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await delete(
        Uri.parse(API.deleteMeeting(meeting.id)),
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
