class Permissions {
  static const String CAN_GRANT_ROLES = 'CAN_GRANT_ROLES';
  static const String CAN_GRANT_PRESIDENT = 'CAN_GRANT_PRESIDENT';
  static const String CAN_GRANT_VICE_PRESIDENT = 'CAN_GRANT_VICE_PRESIDENT';
  static const String CAN_CREATE_MEETINGS = 'CAN_CREATE_MEETINGS';
  static const String CAN_DELETE_MEETINGS = 'CAN_DELETE_MEETINGS';
  static const String CAN_CREATE_INVITATION = 'CAN_CREATE_INVITATION';

  static Map<String, String> translationMap = {
    CAN_GRANT_ROLES: 'Acorda roluri',
    CAN_GRANT_PRESIDENT: 'Acorda rol presedinte',
    CAN_GRANT_VICE_PRESIDENT: 'Acorda rol vice presedinte',
    CAN_CREATE_MEETINGS: 'Creeaza meeting',
    CAN_DELETE_MEETINGS: 'Sterge meeting',
    CAN_CREATE_INVITATION: 'Creeaza invitatie',
  };

  static List<String> Function() toList = () => [
        CAN_GRANT_ROLES,
        CAN_GRANT_PRESIDENT,
        CAN_GRANT_VICE_PRESIDENT,
        CAN_CREATE_MEETINGS,
        CAN_DELETE_MEETINGS,
        CAN_CREATE_INVITATION,
      ];
}
