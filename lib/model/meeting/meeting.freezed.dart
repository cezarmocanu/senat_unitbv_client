// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'meeting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Meeting _$MeetingFromJson(Map<String, dynamic> json) {
  return _Meeting.fromJson(json);
}

/// @nodoc
mixin _$Meeting {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingCopyWith<Meeting> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingCopyWith<$Res> {
  factory $MeetingCopyWith(Meeting value, $Res Function(Meeting) then) =
      _$MeetingCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String title,
      String description,
      DateTime startDate,
      String status});
}

/// @nodoc
class _$MeetingCopyWithImpl<$Res> implements $MeetingCopyWith<$Res> {
  _$MeetingCopyWithImpl(this._value, this._then);

  final Meeting _value;
  // ignore: unused_field
  final $Res Function(Meeting) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_MeetingCopyWith<$Res> implements $MeetingCopyWith<$Res> {
  factory _$$_MeetingCopyWith(
          _$_Meeting value, $Res Function(_$_Meeting) then) =
      __$$_MeetingCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String title,
      String description,
      DateTime startDate,
      String status});
}

/// @nodoc
class __$$_MeetingCopyWithImpl<$Res> extends _$MeetingCopyWithImpl<$Res>
    implements _$$_MeetingCopyWith<$Res> {
  __$$_MeetingCopyWithImpl(_$_Meeting _value, $Res Function(_$_Meeting) _then)
      : super(_value, (v) => _then(v as _$_Meeting));

  @override
  _$_Meeting get _value => super._value as _$_Meeting;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_Meeting(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: startDate == freezed
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Meeting implements _Meeting {
  const _$_Meeting(
      {required this.id,
      required this.title,
      required this.description,
      required this.startDate,
      required this.status});

  factory _$_Meeting.fromJson(Map<String, dynamic> json) =>
      _$$_MeetingFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime startDate;
  @override
  final String status;

  @override
  String toString() {
    return 'Meeting(id: $id, title: $title, description: $description, startDate: $startDate, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Meeting &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.startDate, startDate) &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(startDate),
      const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_MeetingCopyWith<_$_Meeting> get copyWith =>
      __$$_MeetingCopyWithImpl<_$_Meeting>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeetingToJson(
      this,
    );
  }
}

abstract class _Meeting implements Meeting {
  const factory _Meeting(
      {required final int id,
      required final String title,
      required final String description,
      required final DateTime startDate,
      required final String status}) = _$_Meeting;

  factory _Meeting.fromJson(Map<String, dynamic> json) = _$_Meeting.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get startDate;
  @override
  String get status;
  @override
  @JsonKey(ignore: true)
  _$$_MeetingCopyWith<_$_Meeting> get copyWith =>
      throw _privateConstructorUsedError;
}
