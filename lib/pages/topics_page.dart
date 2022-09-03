import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/bottomsheets/add_topic_bs.dart';
import 'package:senat_unit_bv/bottomsheets/leave_meeting_bs.dart';
import 'package:senat_unit_bv/bottomsheets/participants_bs.dart';
import 'package:senat_unit_bv/components/chip_button_outlined.dart';
import 'package:senat_unit_bv/components/topic_card.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/model/topic/topic.dart';
import 'package:senat_unit_bv/services/participation_service.dart';
import 'package:senat_unit_bv/services/topics_service.dart';
import 'package:senat_unit_bv/store/meeting_slice.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class TopicsPage extends StatefulWidget {
  final bool isEditMode;

  const TopicsPage({
    super.key,
    this.isEditMode = false,
  });

  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  late Timer participantsScheduler;
  late List<Topic> _topicsList;
  late bool _loading;

  @override
  void initState() {
    super.initState();
    _topicsList = [];
    _loading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isEditMode) {
        Provider.of<MeetingSlice>(context, listen: false).getParticipants();
      }

      final selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;

      if (selectedMeeting != null) {
        Provider.of<MeetingSlice>(context, listen: false).getParticipants();
        _getTopics(selectedMeeting);

        participantsScheduler = Timer.periodic(const Duration(seconds: 10), (_) {
          if (!mounted) return;

          if (!widget.isEditMode) {
            Provider.of<MeetingSlice>(context, listen: false).getParticipants();
          }
          _getTopics(selectedMeeting);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final numberOfParticipants = Provider.of<MeetingSlice>(context, listen: false).participants.length;
    final selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;
    return WillPopScope(
      onWillPop: () async {
        _handleLeave();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: _handleOnRefresh,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (_loading == true) const LinearProgressIndicator(color: Colors.black12) else const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            selectedMeeting?.title ?? "",
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 3,
                          ),
                        ),
                        if (Provider.of<UserSlice>(context, listen: false).permissions.canCreateTopic)
                          IconButton(
                            onPressed: _handleCreateTopicBs,
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!widget.isEditMode)
                        ChipButtonOutlined(
                          label: 'Participanti ($numberOfParticipants)',
                          iconData: Icons.person_outline,
                          onTap: _handleSeeParticipants,
                          dense: true,
                        ),
                      ChipButtonOutlined(
                        label: widget.isEditMode ? 'Paraseste pregatire' : 'Paraseste meeting',
                        iconData: Icons.cancel,
                        onTap: _handleLeave,
                        dense: true,
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  Flexible(
                    child: ListView.separated(
                      separatorBuilder: (_, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (_, index) {
                        return TopicCard(
                          topic: _topicsList[index],
                          isEditMode: widget.isEditMode,
                          handleActivate: () => _handleActivate(_topicsList[index]),
                          handleVote: _handleVote,
                        );
                      },
                      itemCount: _topicsList.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    if (participantsScheduler.isActive) {
      participantsScheduler.cancel();
    }
  }

  @override
  void dispose() {
    if (participantsScheduler.isActive) {
      participantsScheduler.cancel();
    }
    super.dispose();
  }

  void _handleEditLeave() {
    Provider.of<MeetingSlice>(context, listen: false).selectedMeeting = null;
    Navigator.of(context).pop();
  }

  void _handleLeave() {
    if (widget.isEditMode) {
      _handleEditLeave();
      return;
    }

    LeaveMeetingBs.show(context).then((confirmation) async {
      if (confirmation == true) {
        Meeting? selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;

        if (selectedMeeting == null) {
          Navigator.of(context).pop();
        }

        final response = await ParticipationService.instance.exitMeeting(selectedMeeting!.id);

        if (!mounted) return;

        if (response.statusCode == HttpStatus.ok) {
          Navigator.of(context).pop();
          Provider.of<MeetingSlice>(context, listen: false).selectMeeting(null);
          return;
        }

        const errorSnackBar = SnackBar(
          content: Text('Nu s-a putut iesi din sedinta'),
        );

        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      }
    });
  }

  void _handleSeeParticipants() {
    ParticipantsBs.show(context);
  }

  Future<void> _getTopics(Meeting meeting) async {
    setState(() => _loading = true);
    Response r = await TopicService.instance.getAll(meeting);

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => Topic.fromJson(el)).toList();
      setState(() {
        _topicsList = valuesList;
      });
    }

    setState(() => _loading = false);
  }

  void _handleCreateTopicBs() {
    Meeting? selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;

    if (selectedMeeting == null) {
      Navigator.of(context).pop();
    }

    AddTopicBs.show(context).then((config) async {
      if (config == null) {
        return;
      }

      Response response = await TopicService.instance.create(selectedMeeting!, config);

      if (!mounted) return;

      if (response.statusCode == HttpStatus.created) {
        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Topicul a fost creat cu success'),
        );

        //TODO add topic to list
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Topicul nu a putut fi creat'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  Future<void> _handleOnRefresh() {
    Meeting? selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;

    if (selectedMeeting == null) {
      return Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    }

    return _getTopics(selectedMeeting);
  }

  _handleActivate(Topic topic) async {
    Response response = await TopicService.instance.activate(topic);

    if (!mounted) return;

    if (response.statusCode == HttpStatus.ok) {
      Meeting? selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;
      _getTopics(selectedMeeting!);
    }
  }

  Future<void> _handleVote(Topic topic, String voteValue) async {
    Response response = await TopicService.instance.vote(topic, voteValue);

    if (!mounted) return;

    if (response.statusCode == HttpStatus.ok) {
      Meeting? selectedMeeting = Provider.of<MeetingSlice>(context, listen: false).selectedMeeting;
      _getTopics(selectedMeeting!);
    }
  }
}
