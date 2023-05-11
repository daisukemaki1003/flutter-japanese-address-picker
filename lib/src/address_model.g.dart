// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddressesModel _$$_AddressesModelFromJson(Map<String, dynamic> json) =>
    _$_AddressesModel(
      prefecture: json['prefecture'] as String,
      cites: (json['cites'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_AddressesModelToJson(_$_AddressesModel instance) =>
    <String, dynamic>{
      'prefecture': instance.prefecture,
      'cites': instance.cites,
    };
