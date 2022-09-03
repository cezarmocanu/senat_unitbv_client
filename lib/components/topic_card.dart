import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/components/chip_button_outlined.dart';
import 'package:senat_unit_bv/constants/vote_values.dart';
import 'package:senat_unit_bv/model/topic/topic.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class TopicCard extends StatefulWidget {
  final Topic topic;
  final bool isEditMode;
  final Function handleActivate;
  final Function handleVote;

  const TopicCard({
    Key? key,
    required this.topic,
    this.isEditMode = false,
    required this.handleActivate,
    required this.handleVote,
  }) : super(key: key);

  @override
  State<TopicCard> createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  late bool _loading;
  late bool _didVote;

  @override
  void initState() {
    super.initState();
    _loading = false;
    _didVote = false;
  }

  @override
  Widget build(BuildContext context) {
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
                    widget.topic.content,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
            if (!widget.isEditMode && widget.topic.isActive) ...[
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (_isWinner(VoteValues.YES))
                        const Icon(
                          Icons.star,
                          color: Colors.green,
                          size: 12,
                        ),
                      Text(
                        'DA(${widget.topic.votes[VoteValues.YES]})',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.green,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (_isWinner(VoteValues.ABSTAIN))
                        const Icon(
                          Icons.star,
                          size: 12,
                        ),
                      Text('ABTINERE(${widget.topic.votes[VoteValues.ABSTAIN]})'),
                    ],
                  ),
                  Row(
                    children: [
                      if (_isWinner(VoteValues.NO))
                        const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 12,
                        ),
                      Text(
                        'NU(${widget.topic.votes[VoteValues.NO]})',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.red,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
            const Divider(),
            if (widget.isEditMode) ...[
              const Text("Topicul poate fi trimis la vot doar in momentul participarii la meeting")
            ] else if (widget.topic.isActive) ...[
              if (_currentUserDidVote() || _didVote) ...[
                Row(
                  children: const [
                    Icon(Icons.check),
                    Text("Votul a fost trimis"),
                  ],
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: ChipButtonOutlined(
                        label: 'DA',
                        iconData: Icons.chevron_right,
                        color: Colors.green,
                        onTap: () => _handleVote(widget.topic, VoteValues.YES),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChipButtonOutlined(
                        label: 'ABTINERE',
                        iconData: Icons.chevron_right,
                        onTap: () => _handleVote(widget.topic, VoteValues.ABSTAIN),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ChipButtonOutlined(
                        label: 'NU',
                        iconData: Icons.chevron_right,
                        color: Colors.redAccent,
                        onTap: () => _handleVote(widget.topic, VoteValues.NO),
                      ),
                    ),
                  ],
                ),
              ]
            ] else if (Provider.of<UserSlice>(context, listen: false).permissions.canActivateTopic) ...[
              Row(
                children: [
                  Expanded(
                    child: ChipButtonOutlined(
                      label: 'Trimite spre vot',
                      iconData: Icons.chevron_right,
                      onTap: () => widget.handleActivate(),
                    ),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  Text("Topicul urmeaza sa intre in discutie"),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  bool _currentUserDidVote() {
    User? currentUser = Provider.of<UserSlice>(context, listen: false).currentUser;

    if (currentUser != null) {
      return widget.topic.userWhoVoted.contains(currentUser.id);
    }

    return false;
  }

  void _handleVote(Topic topic, String voteValue) async {
    setState(() {
      _loading = true;
    });

    await widget.handleVote(topic, voteValue);

    setState(() {
      _didVote = true;
      _loading = false;
    });
  }

  bool _isWinner(String voteValue) {
    MapEntry<String, int>? maxPair = widget.topic.votes.entries.fold(null, (result, el) {
      if (result == null) {
        return el;
      }

      if (el.value > result.value) {
        return el;
      }

      return result;
    });

    return maxPair != null && maxPair.key == voteValue && maxPair.value != 0;
  }
}
