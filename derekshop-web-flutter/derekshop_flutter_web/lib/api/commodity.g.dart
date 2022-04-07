// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commodity _$CommodityFromJson(Map<String, dynamic> json) => Commodity(
      coNo: json['coNo'] as String,
      coName: json['coName'] as String,
      coDesc: json['coDesc'] as String,
      coImgUrl: json['coImgUrl'] as String,
      coPrice: json['coPrice'] as int,
      coPayType: json['coPayType'] as String,
      createdUser: json['createdUser'] as String,
      createdTime: DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
      'coNo': instance.coNo,
      'coName': instance.coName,
      'coDesc': instance.coDesc,
      'coImgUrl': instance.coImgUrl,
      'coPrice': instance.coPrice,
      'coPayType': instance.coPayType,
      'createdUser': instance.createdUser,
      'createdTime': instance.createdTime.toIso8601String(),
    };
