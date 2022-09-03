import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:senat_unit_bv/constants/dotenv_keys.dart';

class API {
  static final login = "${dotenv.env[DotenvKeys.host]}/auth-jwt/login";
  static final profile = "${dotenv.env[DotenvKeys.host]}/auth-jwt/profile";
  static final meetings = "${dotenv.env[DotenvKeys.host]}/meetings";
  static final meetingsHistory = "${dotenv.env[DotenvKeys.host]}/meetings/finished";
  static final deleteMeeting = (int meetingId) => "${dotenv.env[DotenvKeys.host]}/meetings/$meetingId";
  static final topics = (int meetingId) => "${dotenv.env[DotenvKeys.host]}/topics/$meetingId";
  static final activateTopic = (int topicId) => "${dotenv.env[DotenvKeys.host]}/topics/activate/$topicId";
  static final voteTopic = (int topicId) => "${dotenv.env[DotenvKeys.host]}/vote/$topicId";
  static final joinMeeting = (int meetingId) => "${dotenv.env[DotenvKeys.host]}/participation/joinMeeting/$meetingId";
  static final exitMeeting = (int meetingId) => "${dotenv.env[DotenvKeys.host]}/participation/exitMeeting/$meetingId";
  static final participants = (int meetingId) => "${dotenv.env[DotenvKeys.host]}/participation/allUsers/$meetingId";
}
