import 'package:json_annotation/json_annotation.dart';

// 這允許User去存取這些產生的檔案中的私有成員
part 'get_jwt_token_res.g.dart';

// 這個修飾符是用來告訴生成器，這個Class是要來產生Model的
@JsonSerializable()
class GetJwtTokenRes {

  final String token;

  GetJwtTokenRes({
    required this.token
  });

  // 這個facotry是必須要有的，為了從map創建一個新的User實例
  // 把整個map傳遞`_$UserFromJson()`
  factory GetJwtTokenRes.fromJson(Map<String, dynamic> json) => _$GetJwtTokenResFromJson(json);

  // `toJson`是用來限制即將進行序列化到JSON
  Map<String, dynamic> toJson() => _$GetJwtTokenResToJson(this);
}