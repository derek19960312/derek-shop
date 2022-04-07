// ignore_for_file: prefer_const_constructors
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('CatalogState', () {
    group('CatalogLoading', () {
      test('supports value comparison', () {
        expect(CatalogLoading(), CatalogLoading());
      });
    });

    group('CatalogLoaded', () {
      test('supports value comparison', () {
        final catalog = Catalog(items: [Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
            payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
          Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
              payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
        ]);
        expect(CatalogLoaded(catalog), CatalogLoaded(catalog));
      });
    });
  });
}
