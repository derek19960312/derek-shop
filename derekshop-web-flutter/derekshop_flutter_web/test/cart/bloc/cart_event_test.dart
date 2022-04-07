// ignore_for_file: prefer_const_constructors
import 'package:derekshop_flutter_web/cart/cart.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeItem extends Fake implements Item {}

void main() {
  group('CartEvent', () {
    group('CartStarted', () {
      test('supports value comparison', () {
        expect(CartStarted(), CartStarted());
      });
    });

    group('CartItemAdded', () {
      final item = FakeItem();
      test('supports value comparison', () {
        expect(CartItemAdded(item), CartItemAdded(item));
      });
    });

    group('CartItemRemoved', () {
      final item = FakeItem();
      test('supports value comparison', () {
        expect(CartItemRemoved(item), CartItemRemoved(item));
      });
    });
  });
}
