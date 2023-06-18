// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_image_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UploadImageResponseModel _$UploadImageResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UploadImageResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UploadImageResponseModel {
  String get originalname => throw _privateConstructorUsedError;
  String get filename => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UploadImageResponseModelCopyWith<UploadImageResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadImageResponseModelCopyWith<$Res> {
  factory $UploadImageResponseModelCopyWith(UploadImageResponseModel value,
          $Res Function(UploadImageResponseModel) then) =
      _$UploadImageResponseModelCopyWithImpl<$Res, UploadImageResponseModel>;
  @useResult
  $Res call({String originalname, String filename, String location});
}

/// @nodoc
class _$UploadImageResponseModelCopyWithImpl<$Res,
        $Val extends UploadImageResponseModel>
    implements $UploadImageResponseModelCopyWith<$Res> {
  _$UploadImageResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalname = null,
    Object? filename = null,
    Object? location = null,
  }) {
    return _then(_value.copyWith(
      originalname: null == originalname
          ? _value.originalname
          : originalname // ignore: cast_nullable_to_non_nullable
              as String,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UploadImageResponseModelCopyWith<$Res>
    implements $UploadImageResponseModelCopyWith<$Res> {
  factory _$$_UploadImageResponseModelCopyWith(
          _$_UploadImageResponseModel value,
          $Res Function(_$_UploadImageResponseModel) then) =
      __$$_UploadImageResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String originalname, String filename, String location});
}

/// @nodoc
class __$$_UploadImageResponseModelCopyWithImpl<$Res>
    extends _$UploadImageResponseModelCopyWithImpl<$Res,
        _$_UploadImageResponseModel>
    implements _$$_UploadImageResponseModelCopyWith<$Res> {
  __$$_UploadImageResponseModelCopyWithImpl(_$_UploadImageResponseModel _value,
      $Res Function(_$_UploadImageResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalname = null,
    Object? filename = null,
    Object? location = null,
  }) {
    return _then(_$_UploadImageResponseModel(
      originalname: null == originalname
          ? _value.originalname
          : originalname // ignore: cast_nullable_to_non_nullable
              as String,
      filename: null == filename
          ? _value.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UploadImageResponseModel implements _UploadImageResponseModel {
  const _$_UploadImageResponseModel(
      {required this.originalname,
      required this.filename,
      required this.location});

  factory _$_UploadImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_UploadImageResponseModelFromJson(json);

  @override
  final String originalname;
  @override
  final String filename;
  @override
  final String location;

  @override
  String toString() {
    return 'UploadImageResponseModel(originalname: $originalname, filename: $filename, location: $location)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UploadImageResponseModel &&
            (identical(other.originalname, originalname) ||
                other.originalname == originalname) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.location, location) ||
                other.location == location));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, originalname, filename, location);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UploadImageResponseModelCopyWith<_$_UploadImageResponseModel>
      get copyWith => __$$_UploadImageResponseModelCopyWithImpl<
          _$_UploadImageResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UploadImageResponseModelToJson(
      this,
    );
  }
}

abstract class _UploadImageResponseModel implements UploadImageResponseModel {
  const factory _UploadImageResponseModel(
      {required final String originalname,
      required final String filename,
      required final String location}) = _$_UploadImageResponseModel;

  factory _UploadImageResponseModel.fromJson(Map<String, dynamic> json) =
      _$_UploadImageResponseModel.fromJson;

  @override
  String get originalname;
  @override
  String get filename;
  @override
  String get location;
  @override
  @JsonKey(ignore: true)
  _$$_UploadImageResponseModelCopyWith<_$_UploadImageResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
