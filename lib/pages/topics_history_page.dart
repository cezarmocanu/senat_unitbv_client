import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:senat_unit_bv/components/topic_history_card.dart';
import 'package:senat_unit_bv/model/meeting/meeting.dart';
import 'package:senat_unit_bv/model/topic/topic.dart';
import 'package:senat_unit_bv/services/topics_service.dart';

class TopicsHistoryPage extends StatefulWidget {
  final Meeting meeting;

  const TopicsHistoryPage({
    super.key,
    required this.meeting,
  });

  @override
  State<TopicsHistoryPage> createState() => _TopicsHistoryPageState();
}

class _TopicsHistoryPageState extends State<TopicsHistoryPage> {
  late List<Topic> _topicsList;
  late bool _loading;

  @override
  void initState() {
    super.initState();
    _topicsList = [];
    _loading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTopics(widget.meeting);
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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        widget.meeting.title,
                        style: Theme.of(context).textTheme.subtitle2,
                        maxLines: 3,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 16),
              Flexible(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (_, index) {
                    return TopicHistoryCard(
                      topic: _topicsList[index],
                    );
                  },
                  itemCount: _topicsList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getTopics(Meeting meeting) async {
    setState(() => _loading = true);
    Response r = await TopicService.instance.getAll(meeting);

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => Topic.fromJson(el)).toList().reversed.toList();
      setState(() {
        _topicsList = valuesList;
      });
    }

    setState(() => _loading = false);
  }
}
