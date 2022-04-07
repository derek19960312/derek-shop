import 'package:json_annotation/json_annotation.dart';

// 這允許User去存取這些產生的檔案中的私有成員
part 'commodity.g.dart';

// 這個修飾符是用來告訴生成器，這個Class是要來產生Model的
@JsonSerializable()
class Commodity {

  final String coNo;
  final String coName;
  final String coDesc;
  final String coImgUrl;
  final int coPrice;
  final String coPayType;
  final String createdUser;
  final DateTime createdTime;

  Commodity({required this.coNo, required this.coName, required this.coDesc, required this.coImgUrl, required this.coPrice,
    required this.coPayType, required this.createdUser, required this.createdTime});

// 這個facotry是必須要有的，為了從map創建一個新的User實例
  // 把整個map傳遞`_$UserFromJson()`
  factory Commodity.fromJson(Map<String, dynamic> json) => _$CommodityFromJson(json);

  // `toJson`是用來限制即將進行序列化到JSON
  Map<String, dynamic> toJson() => _$CommodityToJson(this);
}