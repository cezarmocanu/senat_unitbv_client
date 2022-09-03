import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/shared_prefs_keys.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:senat_unit_bv/services/participation_service.dart';
import 'package:senat_unit_bv/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeetingSlice extends ChangeNotifier {
  Meeting? selectedMeeting;
  List<User> participants = [];

  void selectMeeting(Meeting? meeting) async {
    selectedMeeting = meeting;
    notifyListeners();
  }

  void getParticipants() async {
    if (selectedMeeting == null) {
      return;
    }

    Response r = await ParticipationService.instance.participants(selectedMeeting!.id);

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => User.fromJson(el)).toList();
      participants = valuesList;
    } else {
      participants = [];
    }

    notifyListeners();
  }
}
