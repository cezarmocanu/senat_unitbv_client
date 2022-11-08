import 'package:senat_unit_bv/constants/permissions.dart';

class PermissionSchema {
  final List<String> permissions;

  late bool canInvite;
  late bool canEditRoles;
  late bool canGrantAllRoles;
  late bool canGrantPresident;
  late bool canGrantVicePresident;
  late bool canGrantSenator;

  late bool canCreateMeeting;
  late bool canPrepareMeeting;
  late bool canDeleteMeeting;

  late bool canCreateTopic;
  late bool canActivateTopic;
  late bool canVoteTopic;

  PermissionSchema(this.permissions) {
    canInvite = permissions.contains(Permissions.CAN_CREATE_INVITATION);
    canEditRoles = permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_ALL) ||
        permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_PRESIDENT) ||
        permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_VICEPRESIDENT);

    canGrantAllRoles = permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_ALL);
    canGrantPresident = permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_PRESIDENT);
    canGrantVicePresident = permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_VICEPRESIDENT);

    canCreateMeeting = permissions.contains(Permissions.CAN_CREATE_MEETING);
    canPrepareMeeting = permissions.contains(Permissions.CAN_CREATE_MEETING);
    canDeleteMeeting = permissions.contains(Permissions.CAN_DELETE_MEETING);

    canCreateTopic = permissions.contains(Permissions.CAN_CREATE_MEETING);
    canActivateTopic = permissions.contains(Permissions.CAN_GRANT_PERMISSIONS_PRESIDENT);
    canVoteTopic = permissions.contains(Permissions.CAN_VOTE);
  }
}
