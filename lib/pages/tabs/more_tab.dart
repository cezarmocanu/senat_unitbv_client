import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senat_unit_bv/bottomsheets/invite_bs.dart';
import 'package:senat_unit_bv/bottomsheets/roles_bs.dart';
import 'package:senat_unit_bv/components/meeting_card.dart';
import 'package:senat_unit_bv/components/meeting_history_card.dart';
import 'package:senat_unit_bv/constants/roles.dart';
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
                    onTap: () => InviteBs.show(context),
                  ),
                  const Divider(),
                ],
                if (Provider.of<UserSlice>(context, listen: false).permissions.canEditRoles) ...[
                  ListTile(
                    title: Text("Roluri"),
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
}
