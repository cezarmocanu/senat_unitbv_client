import 'package:flutter/material.dart';
import 'package:senat_unit_bv/components/chip_button_outlined.dart';
import 'package:senat_unit_bv/components/votes_bar_chart.dart';
import 'package:senat_unit_bv/constants/vote_values.dart';
import 'package:senat_unit_bv/model/topic/topic.dart';

class TopicHistoryCard extends StatelessWidget {
  final Topic topic;

  const TopicHistoryCard({
    Key? key,
    required this.topic,
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
                    topic.content,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: VotesBarChart.withData(topic.votes),
            )
          ],
        ),
      ),
    );
  }
}
