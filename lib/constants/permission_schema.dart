import 'package:senat_unit_bv/constants/roles.dart';

class PermissionSchema {
  final String role;

  late bool canInvite;
  late bool canEditRoles;

  late bool canCreateMeeting;
  late bool canPrepareMeeting;
  late bool canDeleteMeeting;

  late bool canCreateTopic;
  late bool canActivateTopic;
  late bool canVoteTopic;

  PermissionSchema(this.role) {
    canInvite = [Roles.ADMIN, Roles.PRESIDENT].contains(role);
    canEditRoles = [Roles.ADMIN, Roles.PRESIDENT].contains(role);

    canCreateMeeting = [Roles.ADMIN, Roles.PRESIDENT].contains(role);
    canPrepareMeeting = [Roles.ADMIN, Roles.PRESIDENT].contains(role);
    canDeleteMeeting = [Roles.ADMIN, Roles.PRESIDENT].contains(role);

    canCreateTopic = [Roles.ADMIN, Roles.PRESIDENT].contains(role);
    canActivateTopic = [Roles.ADMIN, Roles.PRESIDENT].contains(role);
    canVoteTopic = [Roles.ADMIN, Roles.PRESIDENT, Roles.SENATOR].contains(role);
  }
}
