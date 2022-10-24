import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:senat_unit_bv/constants/permissions.dart';
import 'package:senat_unit_bv/model/user/user.dart';
import 'package:senat_unit_bv/services/roles_service.dart';
import 'package:senat_unit_bv/theme.dart';

class RolesBs {
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
  late List<User> _users;
  late bool _loading;

  @override
  void initState() {
    super.initState();
    _users = [];
    _loading = false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            if (_loading == true) const LinearProgressIndicator(color: Colors.black12) else const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Roluri',
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
            Expanded(
              child: Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (_, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (_, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.person_outline),
                                Text(_buildName(_users[index])),
                              ],
                            ),
                            const Divider(),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (_, permissionIndex) {
                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          visualDensity: VisualDensity.compact,
                                          checkColor: Colors.white,
                                          activeColor: AppPalette.primaryColor,
                                          value: _users[index].permissions.contains(Permissions.toList().elementAt(permissionIndex)),
                                          onChanged: (bool? value) {
                                            _updateRole(
                                              _users[index],
                                              Permissions.toList().elementAt(permissionIndex),
                                              !_users[index].permissions.contains(Permissions.toList().elementAt(permissionIndex)),
                                            );
                                          },
                                        ),
                                        Text(Permissions.translationMap[Permissions.toList().elementAt(permissionIndex)] ?? "ROL INVALID"),
                                      ],
                                    );
                                  },
                                  itemCount: Permissions.toList().length,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _users.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getUsers() async {
    setState(() => _loading = true);
    Response r = await RolesService.instance.getPermissions();

    if (r.statusCode == HttpStatus.ok) {
      final valuesList = (json.decode(r.body) as List).map((el) => User.fromJson(el)).toList();
      setState(() {
        _users = valuesList;
      });
    }

    setState(() => _loading = false);
  }

  Future<void> _updateRole(User user, String permission, bool isEnabled) async {
    setState(() => _loading = true);
    await RolesService.instance.updatePermission(user, permission, isEnabled);
    await _getUsers();
  }

  String _buildName(User user) {
    if ((user.firstName ?? '').isEmpty && (user.lastName ?? '').isEmpty) {
      return user.email;
    }

    return '${user.firstName} ${user.lastName}';
  }
}
