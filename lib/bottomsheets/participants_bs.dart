import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:senat_unit_bv/store/meeting_slice.dart';

class ParticipantsBs {
  static void show(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (_) => _Bs(),
    );
  }
}

class _Bs extends StatefulWidget {
  @override
  State<_Bs> createState() => _BsState();
}

class _BsState extends State<_Bs> {
  @override
  Widget build(BuildContext context) {
    final participants = Provider.of<MeetingSlice>(context, listen: false).participants;

    return SizedBox(
      height: MediaQuery.of(context).size.height - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Participanti',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, index) => const SizedBox(height: 8),
                itemBuilder: (_, index) {
                  User participant = participants[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              Text(_buildParticipantName(participant)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: participants.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _buildParticipantName(User participant) {
    if (participant.firstName != null && participant.lastName != null) {
      return "${participant.firstName} ${participant.lastName}";
    }

    return participant.email;
  }
}
