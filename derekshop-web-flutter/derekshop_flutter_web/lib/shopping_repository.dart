import 'dart:async';


import 'package:derekshop_flutter_web/api/commodity.dart';
import 'package:derekshop_flutter_web/locator.dart';

import 'api/api.dart';
import 'api/api_client.dart';
import 'catalog/models/item.dart';

const _delay = Duration(milliseconds: 800);

const _catalog = [
  'Code Smell',
  'Control Flow',
  'Interpreter',
  'Recursion',
  'Sprint',
  'Heisenbug',
  'Spaghetti',
  'Hydra Code',
  'Off-By-One',
  'Scope',
  'Callback',
  'Closure',
  'Automata',
  'Bit Shift',
  'Currying',
];

class ShoppingRepository {
  final _items = <Item>[];

  Future<List<Item>> loadCatalog() async {
    List<Commodity> coms = await locator<Api>().getCommodites();
    List<Item> items = [];
    for (var com in coms) {
      items.add(Item(id: com.coNo, name: com.coName,
        price: com.coPrice, img: com.coImgUrl,
        payType: com.coPayType, desc: com.coDesc, dateTime: com.createdTime,));
    }
    return items;
  }
  Future<List<Item>> loadCartItems() => Future.delayed(_delay, () => _items);

  void addItemToCart(Item item) => _items.add(item);

  void removeItemFromCart(Item item) => _items.remove(item);
}
