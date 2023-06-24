String host = 'http://torium-systems.com:8100';

class API {
  static final login = "${host}/auth-jwt/login";
  static final profile = "${host}/auth-jwt/profile";
  static final invitation = "${host}/invitation";
  static final invitationRegister = "${host}/auth-jwt/invitation/register";
  static final meetings = "${host}/meetings";
  static final meetingsHistory = "${host}/meetings/finished";
  static final deleteMeeting = (int meetingId) => "${host}/meetings/$meetingId";
  static final topics = (int meetingId) => "${host}/topics/$meetingId";
  static final activateTopic = (int topicId) => "${host}/topics/activate/$topicId";
  static final voteTopic = (int topicId) => "${host}/vote/$topicId";
  static final joinMeeting = (int meetingId) => "${host}/participation/joinMeeting/$meetingId";
  static final exitMeeting = (int meetingId) => "${host}/participation/exitMeeting/$meetingId";
  static final participants = (int meetingId) => "${host}/participation/allUsers/$meetingId";

  //BRINGS THE USERS WITH THEIR PERMISSIONS
  static final permissionsUsers = "${host}/user-permissions";
  static final updatePermissions = "${host}/user-permissions/update/permissions";

  // PUT user-permissions/update/permissions
}
