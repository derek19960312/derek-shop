
import 'dart:convert';

import 'package:derekshop_flutter_web/api/api_client.dart';
import 'package:derekshop_flutter_web/api/commodity.dart';
import 'package:derekshop_flutter_web/locator.dart';
import 'package:logger/logger.dart';


class Api {
  final ApiClient _apiClient = locator<ApiClient>();

  Future<List<Commodity>> getCommodites() async {
    Iterable l = await _apiClient.get("commodities");
    locator<Logger>().i(l);
    List<Commodity> commodities = List<Commodity>.from(l.map((model)=> Commodity.fromJson(model)));
    locator<Logger>().i(l);
    return commodities;
  }
}