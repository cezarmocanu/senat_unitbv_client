import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/api.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/model/topic/topic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopicService {
  TopicService._internal();

  static final TopicService instance = TopicService._internal();

  Future<Response> getAll(Meeting meeting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await get(
        Uri.parse(API.topics(meeting.id)),
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

  Future<Response> create(Meeting meeting, Map<String, dynamic> payload) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await post(
        Uri.parse(API.topics(meeting.id)),
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

  Future<Response> activate(Topic topic) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await put(
        Uri.parse(API.activateTopic(topic.id)),
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

  Future<Response> vote(Topic topic, String voteValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString(SharedPrefsKeys.token);

    try {
      final response = await post(
        Uri.parse(API.voteTopic(topic.id)),
        body: json.encode({"voteValue": voteValue}),
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
