// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Topic _$$_TopicFromJson(Map<String, dynamic> json) => _$_Topic(
      id: json['topicId'] as int,
      content: json['content'] as String,
      isActive: json['isActive'] as bool,
      votes: Map<String, int>.from(json['votes'] as Map),
      userWhoVoted: (json['usersWhoVotes'] as List<dynamic>)
          .map((e) => e as int)
          .toList(),
    );

Map<String, dynamic> _$$_TopicToJson(_$_Topic instance) => <String, dynamic>{
      'topicId': instance.id,
      'content': instance.content,
      'isActive': instance.isActive,
      'votes': instance.votes,
      'usersWhoVotes': instance.userWhoVoted,
    };
