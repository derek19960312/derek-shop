import 'package:flutter/material.dart';
import 'package:derekshop_flutter_web/cart/cart.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

import '../../helper.dart';

void main() {
  late CartBloc cartBloc;

  final mockItems = [
    Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
        payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
    Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
        payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
    Item(name: '硬碟', img: 'https://d.ecimg.tw/items/DRAG6FA900A54V5/000001_1637718715.jpg', price: 12988,
        payType: '1', dateTime: DateTime.now(), desc: '硬碟', id: const Uuid().v1()),
  ];

  setUp(() {
    cartBloc = MockCartBloc();
  });

  group('CartPage', () {
    testWidgets('renders CartList and CartTotal', (tester) async {
      when(() => cartBloc.state).thenReturn(CartLoading());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartPage(),
      );
      expect(find.byType(CartList), findsOneWidget);
      expect(find.byType(CartTotal), findsOneWidget);
    });
  });

  group('CartList', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when cart is loading', (tester) async {
      when(() => cartBloc.state).thenReturn(CartLoading());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartList(),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders 3 ListTile '
        'when cart is loaded with three items', (tester) async {
      when(() => cartBloc.state)
          .thenReturn(CartLoaded(cart: Cart(items: mockItems)));
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartList(),
      );
      expect(find.byType(ListTile), findsNWidgets(3));
    });

    testWidgets(
        'renders error text '
        'when cart fails to load', (tester) async {
      when(() => cartBloc.state).thenReturn(CartError());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartList(),
      );
      expect(find.text('Something went wrong!'), findsOneWidget);
    });
  });

  group('CartTotal', () {
    testWidgets(
        'renders CircularProgressIndicator '
        'when cart is loading', (tester) async {
      when(() => cartBloc.state).thenReturn(CartLoading());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartTotal(),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets(
        'renders total price '
        'when cart is loaded with three items', (tester) async {
      when(() => cartBloc.state)
          .thenReturn(CartLoaded(cart: Cart(items: mockItems)));
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartTotal(),
      );
      expect(find.text('\$${42 * 3}'), findsOneWidget);
    });

    testWidgets(
        'renders error text '
        'when cart fails to load', (tester) async {
      when(() => cartBloc.state).thenReturn(CartError());
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: CartTotal(),
      );
      expect(find.text('Something went wrong!'), findsOneWidget);
    });

    testWidgets(
        'renders SnackBar after '
        'tapping the \'BUY\' button', (tester) async {
      when(() => cartBloc.state)
          .thenReturn(CartLoaded(cart: Cart(items: mockItems)));
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: Scaffold(body: CartTotal()),
      );
      await tester.tap(find.text('BUY'));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Buying not supported yet.'), findsOneWidget);
    });

    testWidgets('adds CartItemRemoved on long press', (tester) async {
      when(() => cartBloc.state).thenReturn(
        CartLoaded(cart: Cart(items: mockItems)),
      );
      final mockItemToRemove = mockItems.last;
      await tester.pumpApp(
        cartBloc: cartBloc,
        child: Scaffold(body: CartList()),
      );
      await tester.longPress(find.text(mockItemToRemove.name));
      verify(() => cartBloc.add(CartItemRemoved(mockItemToRemove))).called(1);
    });
  });
}
