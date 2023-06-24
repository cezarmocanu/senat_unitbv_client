import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/bottomsheets/invite_bs.dart';
import 'package:senat_unit_bv/bottomsheets/roles_bs.dart';
import 'package:senat_unit_bv/services/invitation_service.dart';
import 'package:senat_unit_bv/services/meeting_service.dart';
import 'package:senat_unit_bv/store/user_slice.dart';

class MoreTab extends StatefulWidget {
  @override
  State<MoreTab> createState() => _MoreTabState();
}

class _MoreTabState extends State<MoreTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mai multe",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("Profil"),
                  leading: Icon(Icons.person_outline),
                  trailing: Icon(Icons.chevron_right),
                  dense: true,
                  onTap: () {},
                ),
                const Divider(),
                if (Provider.of<UserSlice>(context, listen: false).permissions.canInvite) ...[
                  ListTile(
                    title: Text("Invita"),
                    leading: Icon(Icons.mail_outline),
                    trailing: Icon(Icons.chevron_right),
                    dense: true,
                    onTap: _handleInviteBs,
                  ),
                  const Divider(),
                ],
                if (Provider.of<UserSlice>(context, listen: false).permissions.canEditRoles) ...[
                  ListTile(
                    title: Text("Permissiuni"),
                    leading: Icon(Icons.verified_user_outlined),
                    trailing: Icon(Icons.chevron_right),
                    dense: true,
                    onTap: () => RolesBs.show(context),
                  ),
                  const Divider(),
                ],
                ListTile(
                  title: Text("Deconectare"),
                  leading: Icon(Icons.lock_outline),
                  trailing: Icon(Icons.chevron_right),
                  dense: true,
                  onTap: () {
                    Provider.of<UserSlice>(context, listen: false).logOut().then((_) {
                      Navigator.of(context).pushNamedAndRemoveUntil("/", (_) => false);
                    });
                  },
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleInviteBs() {
    InviteBs.show(context).then((config) async {
      if (config == null) {
        return;
      }

      Response response = await InvitationService.instance.invite(config);

      if (response.statusCode == HttpStatus.created) {
        const snackBar = SnackBar(
          backgroundColor: Colors.green,
          content: Text('Invitatie trimisa cu success'),
        );

        //TODO add meeting to list
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }

      const snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Invitatia nu a putut fi trimsa'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
