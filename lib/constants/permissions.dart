class Permissions {
  static const String CAN_GRANT_PERMISSIONS_ALL = 'CAN_GRANT_PERMISSIONS_ALL';
  static const String CAN_GRANT_PERMISSIONS_PRESIDENT = 'CAN_GRANT_PERMISSIONS_PRESIDENT';
  static const String CAN_GRANT_PERMISSIONS_VICEPRESIDENT = 'CAN_GRANT_PERMISSIONS_VICEPRESIDENT';
  static const String CAN_CREATE_MEETING = 'CAN_CREATE_MEETING';
  static const String CAN_DELETE_MEETING = 'CAN_DELETE_MEETING';
  static const String CAN_CREATE_INVITATION = 'CAN_CREATE_INVITATION';
  static const String CAN_VOTE = 'CAN_VOTE';

  static Map<String, String> translationMap = {
    CAN_GRANT_PERMISSIONS_ALL: "Admin",
    CAN_GRANT_PERMISSIONS_PRESIDENT: "Presedinte",
    CAN_GRANT_PERMISSIONS_VICEPRESIDENT: "Vice Presedinte",
    CAN_CREATE_MEETING: "Poate crea meeting",
    CAN_DELETE_MEETING: "Poate sterge meeting",
    CAN_CREATE_INVITATION: "Poate crea invitatie",
    CAN_VOTE: "Poate vota",
  };

  static List<String> Function() toList = () => [
        CAN_GRANT_PERMISSIONS_ALL,
        CAN_GRANT_PERMISSIONS_PRESIDENT,
        CAN_GRANT_PERMISSIONS_VICEPRESIDENT,
        CAN_CREATE_MEETING,
        CAN_DELETE_MEETING,
        CAN_CREATE_INVITATION,
        CAN_VOTE,
      ];
}
