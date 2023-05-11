// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddressModel {
  String? get prefecture => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call({String? prefecture, String? city});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefecture = freezed,
    Object? city = freezed,
  }) {
    return _then(_value.copyWith(
      prefecture: freezed == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressModelCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$_AddressModelCopyWith(
          _$_AddressModel value, $Res Function(_$_AddressModel) then) =
      __$$_AddressModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? prefecture, String? city});
}

/// @nodoc
class __$$_AddressModelCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$_AddressModel>
    implements _$$_AddressModelCopyWith<$Res> {
  __$$_AddressModelCopyWithImpl(
      _$_AddressModel _value, $Res Function(_$_AddressModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefecture = freezed,
    Object? city = freezed,
  }) {
    return _then(_$_AddressModel(
      prefecture: freezed == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddressModel extends _AddressModel {
  const _$_AddressModel({required this.prefecture, required this.city})
      : super._();

  @override
  final String? prefecture;
  @override
  final String? city;

  @override
  String toString() {
    return 'AddressModel(prefecture: $prefecture, city: $city)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressModel &&
            (identical(other.prefecture, prefecture) ||
                other.prefecture == prefecture) &&
            (identical(other.city, city) || other.city == city));
  }

  @override
  int get hashCode => Object.hash(runtimeType, prefecture, city);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressModelCopyWith<_$_AddressModel> get copyWith =>
      __$$_AddressModelCopyWithImpl<_$_AddressModel>(this, _$identity);
}

abstract class _AddressModel extends AddressModel {
  const factory _AddressModel(
      {required final String? prefecture,
      required final String? city}) = _$_AddressModel;
  const _AddressModel._() : super._();

  @override
  String? get prefecture;
  @override
  String? get city;
  @override
  @JsonKey(ignore: true)
  _$$_AddressModelCopyWith<_$_AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressesModel _$AddressesModelFromJson(Map<String, dynamic> json) {
  return _AddressesModel.fromJson(json);
}

/// @nodoc
mixin _$AddressesModel {
  String get prefecture => throw _privateConstructorUsedError;
  List<String> get cites => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddressesModelCopyWith<AddressesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressesModelCopyWith<$Res> {
  factory $AddressesModelCopyWith(
          AddressesModel value, $Res Function(AddressesModel) then) =
      _$AddressesModelCopyWithImpl<$Res, AddressesModel>;
  @useResult
  $Res call({String prefecture, List<String> cites});
}

/// @nodoc
class _$AddressesModelCopyWithImpl<$Res, $Val extends AddressesModel>
    implements $AddressesModelCopyWith<$Res> {
  _$AddressesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefecture = null,
    Object? cites = null,
  }) {
    return _then(_value.copyWith(
      prefecture: null == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      cites: null == cites
          ? _value.cites
          : cites // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddressesModelCopyWith<$Res>
    implements $AddressesModelCopyWith<$Res> {
  factory _$$_AddressesModelCopyWith(
          _$_AddressesModel value, $Res Function(_$_AddressesModel) then) =
      __$$_AddressesModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String prefecture, List<String> cites});
}

/// @nodoc
class __$$_AddressesModelCopyWithImpl<$Res>
    extends _$AddressesModelCopyWithImpl<$Res, _$_AddressesModel>
    implements _$$_AddressesModelCopyWith<$Res> {
  __$$_AddressesModelCopyWithImpl(
      _$_AddressesModel _value, $Res Function(_$_AddressesModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prefecture = null,
    Object? cites = null,
  }) {
    return _then(_$_AddressesModel(
      prefecture: null == prefecture
          ? _value.prefecture
          : prefecture // ignore: cast_nullable_to_non_nullable
              as String,
      cites: null == cites
          ? _value._cites
          : cites // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddressesModel implements _AddressesModel {
  const _$_AddressesModel(
      {required this.prefecture, required final List<String> cites})
      : _cites = cites;

  factory _$_AddressesModel.fromJson(Map<String, dynamic> json) =>
      _$$_AddressesModelFromJson(json);

  @override
  final String prefecture;
  final List<String> _cites;
  @override
  List<String> get cites {
    if (_cites is EqualUnmodifiableListView) return _cites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cites);
  }

  @override
  String toString() {
    return 'AddressesModel(prefecture: $prefecture, cites: $cites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddressesModel &&
            (identical(other.prefecture, prefecture) ||
                other.prefecture == prefecture) &&
            const DeepCollectionEquality().equals(other._cites, _cites));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, prefecture, const DeepCollectionEquality().hash(_cites));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddressesModelCopyWith<_$_AddressesModel> get copyWith =>
      __$$_AddressesModelCopyWithImpl<_$_AddressesModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddressesModelToJson(
      this,
    );
  }
}

abstract class _AddressesModel implements AddressesModel {
  const factory _AddressesModel(
      {required final String prefecture,
      required final List<String> cites}) = _$_AddressesModel;

  factory _AddressesModel.fromJson(Map<String, dynamic> json) =
      _$_AddressesModel.fromJson;

  @override
  String get prefecture;
  @override
  List<String> get cites;
  @override
  @JsonKey(ignore: true)
  _$$_AddressesModelCopyWith<_$_AddressesModel> get copyWith =>
      throw _privateConstructorUsedError;
}
