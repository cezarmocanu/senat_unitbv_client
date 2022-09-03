import 'package:flutter/material.dart';
import 'package:senat_unit_bv/components/chip_button_full.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';

class MeetingHistoryCard extends StatelessWidget {
  final Function handleDetails;
  final Meeting meeting;

  const MeetingHistoryCard({
    Key? key,
    required this.handleDetails,
    required this.meeting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    meeting.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                ChipButtonFull(
                  label: 'Detalii',
                  iconData: Icons.info_outline,
                  onTap: () {
                    handleDetails();
                  },
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
                        meeting.description,
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
    final startingDate = [
      meeting.startDate.day,
      meeting.startDate.month,
      meeting.startDate.year,
    ].join("/");

    final startingTime = [
      meeting.startDate.hour,
      meeting.startDate.minute,
    ].join(":");

    return "$startingDate $startingTime";
  }
}
