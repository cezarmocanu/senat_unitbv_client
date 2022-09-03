// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Topic _$TopicFromJson(Map<String, dynamic> json) {
  return _Topic.fromJson(json);
}

/// @nodoc
mixin _$Topic {
  @JsonKey(name: 'topicId')
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  Map<String, int> get votes => throw _privateConstructorUsedError;
  @JsonKey(name: 'usersWhoVotes')
  List<int> get userWhoVoted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopicCopyWith<Topic> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicCopyWith<$Res> {
  factory $TopicCopyWith(Topic value, $Res Function(Topic) then) =
      _$TopicCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'topicId') int id,
      String content,
      bool isActive,
      Map<String, int> votes,
      @JsonKey(name: 'usersWhoVotes') List<int> userWhoVoted});
}

/// @nodoc
class _$TopicCopyWithImpl<$Res> implements $TopicCopyWith<$Res> {
  _$TopicCopyWithImpl(this._value, this._then);

  final Topic _value;
  // ignore: unused_field
  final $Res Function(Topic) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? isActive = freezed,
    Object? votes = freezed,
    Object? userWhoVoted = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      votes: votes == freezed
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      userWhoVoted: userWhoVoted == freezed
          ? _value.userWhoVoted
          : userWhoVoted // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
abstract class _$$_TopicCopyWith<$Res> implements $TopicCopyWith<$Res> {
  factory _$$_TopicCopyWith(_$_Topic value, $Res Function(_$_Topic) then) =
      __$$_TopicCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'topicId') int id,
      String content,
      bool isActive,
      Map<String, int> votes,
      @JsonKey(name: 'usersWhoVotes') List<int> userWhoVoted});
}

/// @nodoc
class __$$_TopicCopyWithImpl<$Res> extends _$TopicCopyWithImpl<$Res>
    implements _$$_TopicCopyWith<$Res> {
  __$$_TopicCopyWithImpl(_$_Topic _value, $Res Function(_$_Topic) _then)
      : super(_value, (v) => _then(v as _$_Topic));

  @override
  _$_Topic get _value => super._value as _$_Topic;

  @override
  $Res call({
    Object? id = freezed,
    Object? content = freezed,
    Object? isActive = freezed,
    Object? votes = freezed,
    Object? userWhoVoted = freezed,
  }) {
    return _then(_$_Topic(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: isActive == freezed
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      votes: votes == freezed
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as Map<String, int>,
      userWhoVoted: userWhoVoted == freezed
          ? _value._userWhoVoted
          : userWhoVoted // ignore: cast_nullable_to_non_nullable
              as List<int>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Topic implements _Topic {
  const _$_Topic(
      {@JsonKey(name: 'topicId') required this.id,
      required this.content,
      required this.isActive,
      required final Map<String, int> votes,
      @JsonKey(name: 'usersWhoVotes') required final List<int> userWhoVoted})
      : _votes = votes,
        _userWhoVoted = userWhoVoted;

  factory _$_Topic.fromJson(Map<String, dynamic> json) =>
      _$$_TopicFromJson(json);

  @override
  @JsonKey(name: 'topicId')
  final int id;
  @override
  final String content;
  @override
  final bool isActive;
  final Map<String, int> _votes;
  @override
  Map<String, int> get votes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_votes);
  }

  final List<int> _userWhoVoted;
  @override
  @JsonKey(name: 'usersWhoVotes')
  List<int> get userWhoVoted {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userWhoVoted);
  }

  @override
  String toString() {
    return 'Topic(id: $id, content: $content, isActive: $isActive, votes: $votes, userWhoVoted: $userWhoVoted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Topic &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.isActive, isActive) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            const DeepCollectionEquality()
                .equals(other._userWhoVoted, _userWhoVoted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(isActive),
      const DeepCollectionEquality().hash(_votes),
      const DeepCollectionEquality().hash(_userWhoVoted));

  @JsonKey(ignore: true)
  @override
  _$$_TopicCopyWith<_$_Topic> get copyWith =>
      __$$_TopicCopyWithImpl<_$_Topic>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopicToJson(
      this,
    );
  }
}

abstract class _Topic implements Topic {
  const factory _Topic(
      {@JsonKey(name: 'topicId')
          required final int id,
      required final String content,
      required final bool isActive,
      required final Map<String, int> votes,
      @JsonKey(name: 'usersWhoVotes')
          required final List<int> userWhoVoted}) = _$_Topic;

  factory _Topic.fromJson(Map<String, dynamic> json) = _$_Topic.fromJson;

  @override
  @JsonKey(name: 'topicId')
  int get id;
  @override
  String get content;
  @override
  bool get isActive;
  @override
  Map<String, int> get votes;
  @override
  @JsonKey(name: 'usersWhoVotes')
  List<int> get userWhoVoted;
  @override
  @JsonKey(ignore: true)
  _$$_TopicCopyWith<_$_Topic> get copyWith =>
      throw _privateConstructorUsedError;
}
