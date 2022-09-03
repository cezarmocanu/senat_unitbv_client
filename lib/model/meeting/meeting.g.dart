// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Meeting _$$_MeetingFromJson(Map<String, dynamic> json) => _$_Meeting(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_MeetingToJson(_$_Meeting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'status': instance.status,
    };
