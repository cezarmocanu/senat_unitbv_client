import 'package:freezed_annotation/freezed_annotation.dart';
part 'meeting.freezed.dart';
part 'meeting.g.dart';

@freezed
class Meeting with _$Meeting {
  const factory Meeting({
    required int id,
    required String title,
    required String description,
    required DateTime startDate,
    required String status,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) => _$MeetingFromJson(json);
}
