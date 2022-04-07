
import 'package:bloc_test/bloc_test.dart';
import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:derekshop_flutter_web/cart/cart.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  group('CartBloc', () {
    final mockItems = [
      Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
          payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
      Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
          payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
      Item(name: '硬碟', img: 'https://d.ecimg.tw/items/DRAG6FA900A54V5/000001_1637718715.jpg', price: 12988,
          payType: '1', dateTime: DateTime.now(), desc: '硬碟', id: const Uuid().v1()),
    ];

    final mockItemToAdd = Item(name: 'Wifi', img: 'https://d.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 599,
        payType: '1', dateTime: DateTime.now(), desc: 'Wifi', id: const Uuid().v1());
    final mockItemToRemove = Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
        payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1());

    late ShoppingRepository shoppingRepository;

    setUp(() {
      shoppingRepository = MockShoppingRepository();
    });

    test('initial state is CartLoading', () {
      expect(
        CartBloc(shoppingRepository: shoppingRepository).state,
        CartLoading(),
      );
    });

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartLoaded] when cart is loaded successfully',
      setUp: () {
        when(shoppingRepository.loadCartItems).thenAnswer((_) async => []);
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CartStarted()),
      expect: () => <CartState>[CartLoading(), const CartLoaded()],
      verify: (_) => verify(shoppingRepository.loadCartItems).called(1),
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoading, CartError] when loading the cart throws an error',
      setUp: () {
        when(shoppingRepository.loadCartItems).thenThrow(Exception('Error'));
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc..add(CartStarted()),
      expect: () => <CartState>[CartLoading(), CartError()],
      verify: (_) => verify(shoppingRepository.loadCartItems).called(1),
    );

    blocTest<CartBloc, CartState>(
      'emits [] when cart is not finished loading and item is added',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenAnswer((_) async {});
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[],
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] when item is added successfully',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenAnswer((_) async {});
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[
        CartLoaded(cart: Cart(items: [...mockItems, mockItemToAdd]))
      ],
      verify: (_) {
        verify(() => shoppingRepository.addItemToCart(mockItemToAdd)).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartError] when item is not added successfully',
      setUp: () {
        when(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).thenThrow(Exception('Error'));
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemAdded(mockItemToAdd)),
      expect: () => <CartState>[CartError()],
      verify: (_) {
        verify(
          () => shoppingRepository.addItemToCart(mockItemToAdd),
        ).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartLoaded] when item is removed successfully',
      setUp: () {
        when(
          () => shoppingRepository.removeItemFromCart(mockItemToRemove),
        ).thenAnswer((_) async {});
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemRemoved(mockItemToRemove)),
      expect: () => <CartState>[
        CartLoaded(cart: Cart(items: [...mockItems]..remove(mockItemToRemove)))
      ],
      verify: (_) {
        verify(
          () => shoppingRepository.removeItemFromCart(mockItemToRemove),
        ).called(1);
      },
    );

    blocTest<CartBloc, CartState>(
      'emits [CartError] when item is not removed successfully',
      setUp: () {
        when(
          () => shoppingRepository.removeItemFromCart(mockItemToRemove),
        ).thenThrow(Exception('Error'));
      },
      build: () => CartBloc(shoppingRepository: shoppingRepository),
      seed: () => CartLoaded(cart: Cart(items: mockItems)),
      act: (bloc) => bloc.add(CartItemRemoved(mockItemToRemove)),
      expect: () => <CartState>[CartError()],
      verify: (_) {
        verify(
          () => shoppingRepository.removeItemFromCart(mockItemToRemove),
        ).called(1);
      },
    );
  });
}
