import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/components/chip_button_full.dart';
import 'package:senat_unit_bv/components/chip_button_outlined.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/services/meeting_service.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class MeetingCard extends StatefulWidget {
  final Function handleParticipate;
  final Function handlePrepare;
  final Meeting meeting;

  const MeetingCard({
    super.key,
    required this.handleParticipate,
    required this.handlePrepare,
    required this.meeting,
  });

  @override
  State<MeetingCard> createState() => _MeetingCardState();
}

class _MeetingCardState extends State<MeetingCard> {
  late bool _loading;
  late bool _deleted;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _deleted = false;
  }

  @override
  Widget build(BuildContext context) {
    if (_deleted == true) {
      return Container();
    }

    if (_loading == true) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    widget.meeting.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ChipButtonFull(
                      label: 'Participa',
                      iconData: Icons.check,
                      onTap: () => widget.handleParticipate(),
                      dense: true,
                    ),
                    const SizedBox(width: 4),
                    if (Provider.of<UserSlice>(context, listen: false).permissions.canPrepareMeeting)
                      ChipButtonOutlined(
                        label: 'Pregateste',
                        iconData: Icons.edit_outlined,
                        onTap: () => widget.handlePrepare(),
                        dense: true,
                      ),
                  ],
                ),
                if (Provider.of<UserSlice>(context, listen: false).permissions.canDeleteMeeting)
                  ChipButtonOutlined(
                    label: 'Sterge',
                    iconData: Icons.remove_circle_outline,
                    onTap: _handleDeleteMeeting,
                    dense: true,
                  ),
              ],
            ),
            const Divider(),
            Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, size: 12),
                    Text(_buildMeetingTime()),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.meeting.description,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _buildMeetingTime() {
    final now = DateTime.now();

    final isToday = [
      now.day == widget.meeting.startDate.day,
      now.month == widget.meeting.startDate.month,
      now.year == widget.meeting.startDate.year,
    ].every((c) => c == true);

    if (isToday == false) {
      final startingDate = [
        widget.meeting.startDate.day,
        widget.meeting.startDate.month,
        widget.meeting.startDate.year,
      ].join("/");

      final startingTime = [
        widget.meeting.startDate.hour,
        widget.meeting.startDate.minute,
      ].join(":");

      return "$startingDate $startingTime";
    }

    final remainigTime = widget.meeting.startDate.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
    final isInFuture = remainigTime > 0;

    if (isInFuture == true) {
      final remainingMinutes = remainigTime ~/ 60000;
      final hours = remainingMinutes ~/ 60;
      final minutes = remainingMinutes - hours * 60;

      return "Incepe în $hours ore $minutes minute";
    }

    final remainingMinutes = remainigTime ~/ 60000;
    final hours = remainingMinutes ~/ 60;
    final minutes = remainingMinutes - hours * 60;

    return "A început de ${hours.abs()} ore ${minutes.abs()} minute";
  }

  void _handleDeleteMeeting() async {
    setState(() {
      _loading = true;
    });
    Response response = await MeetingService.instance.deleteMeeting(widget.meeting);

    if (!mounted) return;

    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (response.statusCode == HttpStatus.ok) {
      const snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Meetingul a fost sters cu success'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      setState(() {
        _deleted = true;
        _loading = false;
      });
      return;
    }

    const snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text('Meetingul nu a putut fi sters'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    setState(() {
      _loading = false;
    });
  }
}
