import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('ShoppingRepository', () {
    late ShoppingRepository shoppingRepository;

    setUp(() {
      shoppingRepository = ShoppingRepository();
    });

    group('loadCatalog', () {
      test('returns list of item names', () {
        const items = [
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
        expect(
          shoppingRepository.loadCatalog(),
          completion(equals(items)),
        );
      });
    });

    group('loadCartItems', () {
      test('return empty list after loading cart items', () {
        expect(
          shoppingRepository.loadCartItems(),
          completion(equals(<Item>[])),
        );
      });
    });

    group('addItemToCart', () {
      test('returns newly added item after adding item to cart', () {
        final item = Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
            payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1());
        shoppingRepository.addItemToCart(item);
        expect(
          shoppingRepository.loadCartItems(),
          completion(equals([item])),
        );
      });
    });

    group('removeItemFromCart', () {
      test('removes item from cart', () {
        final item = Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
            payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1());
        shoppingRepository
          ..addItemToCart(item)
          ..removeItemFromCart(item);
        expect(
          shoppingRepository.loadCartItems(),
          completion(equals(<Item>[])),
        );
      });
    });
  });
}
