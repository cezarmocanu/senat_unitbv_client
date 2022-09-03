import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:senat_unit_bv/components/meeting_history_card.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/pages/topics_history_page.dart';
import 'package:senat_unit_bv/services/meeting_service.dart';

class HistoryTab extends StatefulWidget {
  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  late List<Meeting> _meetingsList;
  late Timer _meetingsScheduler;
  late bool _meetingsLoading;

  @override
  void initState() {
    super.initState();
    _meetingsList = [];
    _meetingsLoading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getMeetings();

      if (!mounted) return;

      _meetingsScheduler = Timer.periodic(const Duration(seconds: 30), (_) {
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
          child: Column(
            children: [
              if (_meetingsLoading == true) const LinearProgressIndicator(color: Colors.black12) else const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Istoric sedinte",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(4.0),
              //   child: Row(
              //     children: [
              //       Icon(Icons.calendar_today, size: Theme.of(context).textTheme.subtitle2!.fontSize),
              //       const SizedBox(width: 4),
              //       Text(
              //         "21 August 2022",
              //         style: Theme.of(context).textTheme.subtitle2,
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (_, index) {
                    return MeetingHistoryCard(
                      meeting: _meetingsList[index],
                      handleDetails: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TopicsHistoryPage(
                              meeting: _meetingsList[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  itemCount: _meetingsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    if (_meetingsScheduler.isActive) {
      _meetingsScheduler.cancel();
    }
  }

  @override
  void dispose() {
    if (_meetingsScheduler.isActive) {
      _meetingsScheduler.cancel();
    }
    super.dispose();
  }

  Future<void> _getMeetings() async {
    setState(() => _meetingsLoading = true);
    Response r = await MeetingService.instance.getHistory();

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => Meeting.fromJson(el)).toList().toList();
      valuesList.sort((a, b) => b.startDate.millisecondsSinceEpoch.compareTo(a.startDate.millisecondsSinceEpoch));
      setState(() {
        _meetingsList = valuesList;
      });
    }

    setState(() => _meetingsLoading = false);
  }
}
