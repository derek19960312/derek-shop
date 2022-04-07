import 'package:flutter/material.dart';
import 'package:derekshop_flutter_web/cart/cart.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../helper.dart';

void main() {
  late CartBloc cartBloc;
  late CatalogBloc catalogBloc;

  setUp(() {
    catalogBloc = MockCatalogBloc();
    cartBloc = MockCartBloc();
  });

  group('CatalogPage', () {
    testWidgets(
        'renders SliverFillRemaining with loading indicator '
        'when catalog is loading', (tester) async {
      when(() => catalogBloc.state).thenReturn(CatalogLoading());
      await tester.pumpApp(
        catalogBloc: catalogBloc,
        child: CatalogPage(),
      );
      expect(
        find.descendant(
          of: find.byType(SliverFillRemaining),
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'renders SliverList with two items '
        'when catalog is loaded', (tester) async {
      final catalog = Catalog(items: [Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
          payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
        Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
            payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
      ]);
      when(() => catalogBloc.state).thenReturn(CatalogLoaded(catalog));
      when(() => cartBloc.state).thenReturn(CartLoading());
      await tester.pumpApp(
        cartBloc: cartBloc,
        catalogBloc: catalogBloc,
        child: CatalogPage(),
      );

      expect(find.byType(SliverList), findsOneWidget);
      expect(find.byType(CatalogListItem), findsNWidgets(2));
    });

    testWidgets(
        'renders error text '
        'when catalog fails to load', (tester) async {
      when(() => catalogBloc.state).thenReturn(CatalogError());
      await tester.pumpApp(
        catalogBloc: catalogBloc,
        child: CatalogPage(),
      );

      expect(find.text('Something went wrong!'), findsOneWidget);
    });
  });

  group('AddButton', () {
    final mockItem = Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
        payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1());
    testWidgets(
        'renders CircularProgressIndicator when '
        'cart is loading', (tester) async {
      when(() => cartBloc.state).thenReturn(CartLoading());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: AddButton(item: mockItem),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders \'Add\' text button '
        'when item is not in the cart', (tester) async {
      when(() => cartBloc.state).thenReturn(const CartLoaded());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: AddButton(item: mockItem),
      );
      expect(find.text('ADD'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets(
        'renders check icon '
        'when item is already added to cart', (tester) async {
      when(() => cartBloc.state).thenReturn(
        CartLoaded(cart: Cart(items: [mockItem])),
      );
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: AddButton(item: mockItem),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('ADD'), findsNothing);
    });

    testWidgets('adds item to the cart', (tester) async {
      when(() => cartBloc.state).thenReturn(const CartLoaded());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: AddButton(item: mockItem),
      );

      await tester.tap(find.text('ADD'));
      verify(() => cartBloc.add(CartItemAdded(mockItem))).called(1);
    });
  });
}
