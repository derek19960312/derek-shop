import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('Catalog', () {
    final mockItems = [
      Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
          payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
      Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
          payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
      Item(name: '硬碟', img: 'https://d.ecimg.tw/items/DRAG6FA900A54V5/000001_1637718715.jpg', price: 12988,
          payType: '1', dateTime: DateTime.now(), desc: '硬碟', id: const Uuid().v1()),
    ];
    test('supports value comparison', () async {
      expect(
        Catalog(items: mockItems),
        Catalog(items: mockItems),
      );
    });

    // test('gets correct item by id', () async {
    //   expect(
    //     Catalog(items: mockItems).getById(1),
    //     Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
    //         payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
    //
    //   );
    // });

    // test('gets correct item by id', () async {
    //   expect(
    //     Catalog(itemNames: mockItemNames).getByPosition(2),
    //     Item(2, 'Macaroons'),
    //   );
    // });
  });
}
