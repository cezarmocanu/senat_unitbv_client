import 'package:freezed_annotation/freezed_annotation.dart';
part 'topic.freezed.dart';
part 'topic.g.dart';

@freezed
class Topic with _$Topic {
  const factory Topic({
    @JsonKey(name: 'topicId') required int id,
    required String content,
    required bool isActive,
    required Map<String, int> votes,
    @JsonKey(name: 'usersWhoVotes') required List<int> userWhoVoted,
  }) = _Topic;

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
}
