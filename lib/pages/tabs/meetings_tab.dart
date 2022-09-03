import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/bottomsheets/add_meeting_bs.dart';
import 'package:senat_unit_bv/bottomsheets/enter_meeting_bs.dart';
import 'package:senat_unit_bv/components/meeting_card.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/pages/topics_page.dart';
import 'package:senat_unit_bv/services/meeting_service.dart';
import 'package:senat_unit_bv/services/participation_service.dart';
import 'package:senat_unit_bv/store/meeting_slice.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class MeetingsTab extends StatefulWidget {
  const MeetingsTab({super.key});

  @override
  State<MeetingsTab> createState() => _MeetingsTabState();
}

class _MeetingsTabState extends State<MeetingsTab> {
  late List<Meeting> meetingsList;
  late Timer meetingsScheduler;
  late bool _meetingsLoading;

  @override
  void initState() {
    super.initState();
    meetingsList = [];
    _meetingsLoading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getMeetings();

      if (!mounted) return;
      meetingsScheduler = Timer.periodic(const Duration(seconds: 30), (_) {
        _getMeetings();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: _handleOnRefresh,
            child: Column(
              children: [
                if (_meetingsLoading == true) const LinearProgressIndicator(color: Colors.black12) else const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Program sedinte",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Row(
                        children: [
                          if (Provider.of<UserSlice>(context, listen: false).permissions.canCreateMeeting)
                            IconButton(
                              onPressed: _handleCreateBs,
                              icon: const Icon(
                                Icons.add_circle_outline,
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: Theme.of(context).textTheme.subtitle2!.fontSize,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _buildNowString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.separated(
                    separatorBuilder: (_, index) {
                      return const SizedBox(height: 8);
                    },
                    itemBuilder: (_, index) {
                      return MeetingCard(
                        handleParticipate: () => _handleParticipate(meetingsList[index]),
                        handlePrepare: () => _handlePrepare(meetingsList[index]),
                        meeting: meetingsList[index],
                      );
                    },
                    itemCount: meetingsList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    if (meetingsScheduler.isActive) {
      meetingsScheduler.cancel();
    }
  }

  @override
  void dispose() {
    if (meetingsScheduler.isActive) {
      meetingsScheduler.cancel();
    }
    super.dispose();
  }

  void _handleParticipate(Meeting meeting) {
    EnterMeetingBs.show(context).then((confirmation) async {
      if (confirmation == true) {
        final response = await ParticipationService.instance.joinMeeting(meeting.id);
        if (!mounted) return;

        if (response.statusCode == HttpStatus.created) {
          Provider.of<MeetingSlice>(context, listen: false).selectMeeting(meeting);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TopicsPage()));
          return;
        }

        const errorSnackBar = SnackBar(
          content: Text('Nu s-a putut intra in sedinta'),
        );

        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    });
  }

  void _handlePrepare(Meeting meeting) {
    Provider.of<MeetingSlice>(context, listen: false).selectMeeting(meeting);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const TopicsPage(isEditMode: true)));
  }

  Future<void> _getMeetings() async {
    setState(() => _meetingsLoading = true);
    Response r = await MeetingService.instance.getAll();

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => Meeting.fromJson(el)).toList();
      valuesList.sort((a, b) => a.startDate.millisecondsSinceEpoch.compareTo(b.startDate.millisecondsSinceEpoch));
      setState(() {
        meetingsList = valuesList;
      });
    }

    setState(() => _meetingsLoading = false);
  }

  void _handleCreateBs() {
    AddMeetingBs.show(context).then((config) async {
      if (config == null) {
        return;
      }

      Response response = await MeetingService.instance.create(config);

      if (response.statusCode == HttpStatus.created) {
        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Meetingul a fost creat cu success'),
        );

        //TODO add meeting to list
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Meetingul nu a putut fi creat'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> _handleOnRefresh() {
    return _getMeetings();
  }

  String _buildNowString() {
    final DateTime now = DateTime.now();
    return [
      now.day,
      now.month,
      now.year,
    ].join(" ");
  }
}
