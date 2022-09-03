String host = 'https://vot-senat.herokuapp.com';

class API {
  static final login = "${host}/auth-jwt/login";
  static final profile = "${host}/auth-jwt/profile";
  static final meetings = "${host}/meetings";
  static final meetingsHistory = "${host}/meetings/finished";
  static final deleteMeeting = (int meetingId) => "${host}/meetings/$meetingId";
  static final topics = (int meetingId) => "${host}/topics/$meetingId";
  static final activateTopic = (int topicId) => "${host}/topics/activate/$topicId";
  static final voteTopic = (int topicId) => "${host}/vote/$topicId";
  static final joinMeeting = (int meetingId) => "${host}/participation/joinMeeting/$meetingId";
  static final exitMeeting = (int meetingId) => "${host}/participation/exitMeeting/$meetingId";
  static final participants = (int meetingId) => "${host}/participation/allUsers/$meetingId";
}
