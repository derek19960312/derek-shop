import 'package:flutter/material.dart';
import 'package:derekshop_flutter_web/app.dart';
import 'package:derekshop_flutter_web/cart/cart.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  group('App', () {
    late ShoppingRepository shoppingRepository;

    setUp(() {
      shoppingRepository = MockShoppingRepository();
      when(shoppingRepository.loadCatalog).thenAnswer(
        (_) async => <Item>[Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
            payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
          Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
              payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
        ],
      );
    });

    testWidgets('renders CatalogPage', (tester) async {
      await tester.pumpWidget(App(shoppingRepository: shoppingRepository));
      expect(find.byType(CatalogPage), findsOneWidget);
    });

    testWidgets('renders CatalogPage (initial route)', (tester) async {
      await tester.pumpWidget(App(shoppingRepository: shoppingRepository));
      expect(find.byType(CatalogPage), findsOneWidget);
    });

    testWidgets(
        'can navigate back and forth '
        'between CartPage and CatalogPage', (tester) async {
      await tester.pumpWidget(App(shoppingRepository: shoppingRepository));

      await tester.tap(find.byIcon(Icons.shopping_cart));
      await tester.pumpAndSettle();

      expect(find.byType(CartPage), findsOneWidget);
      expect(find.byType(CatalogPage), findsNothing);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(CartPage), findsNothing);
      expect(find.byType(CatalogPage), findsOneWidget);
    });
  });
}
