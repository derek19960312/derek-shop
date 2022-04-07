import 'package:bloc_test/bloc_test.dart';
import 'package:derekshop_flutter_web/catalog/catalog.dart';
import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

class MockShoppingRepository extends Mock implements ShoppingRepository {}

void main() {
  group('CatalogBloc', () {
    final mockItems = [
      Item(name: '分享器', img: 'https://f.ecimg.tw/items/DRAN09A900BTE4S/000001_1636947115.jpg', price: 2099,
          payType: '1', dateTime: DateTime.now(), desc: '分享器', id: const Uuid().v1()),
      Item(name: '記憶體', img: 'https://d.ecimg.tw/items/DRAC49A900BWEIV/000001_1637717120.jpg', price: 599,
          payType: '1', dateTime: DateTime.now(), desc: '記憶體', id: const Uuid().v1()),
      Item(name: '硬碟', img: 'https://d.ecimg.tw/items/DRAG6FA900A54V5/000001_1637718715.jpg', price: 12988,
          payType: '1', dateTime: DateTime.now(), desc: '硬碟', id: const Uuid().v1()),
    ];

    late ShoppingRepository shoppingRepository;

    setUp(() {
      shoppingRepository = MockShoppingRepository();
    });

    test('initial state is CatalogLoading', () {
      expect(
        CatalogBloc(shoppingRepository: shoppingRepository).state,
        CatalogLoading(),
      );
    });

    blocTest<CatalogBloc, CatalogState>(
      'emits [CatalogLoading, CatalogLoaded] '
      'when catalog is loaded successfully',
      setUp: () {
        when(shoppingRepository.loadCatalog).thenAnswer(
          (_) async => mockItems,
        );
      },
      build: () => CatalogBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CatalogStarted()),
      expect: () => <CatalogState>[
        CatalogLoading(),
        CatalogLoaded(Catalog(items: mockItems)),
      ],
      verify: (_) => verify(shoppingRepository.loadCatalog).called(1),
    );

    blocTest<CatalogBloc, CatalogState>(
      'emits [CatalogLoading, CatalogError] '
      'when loading the catalog throws an exception',
      setUp: () {
        when(shoppingRepository.loadCatalog).thenThrow(Exception('Error'));
      },
      build: () => CatalogBloc(shoppingRepository: shoppingRepository),
      act: (bloc) => bloc.add(CatalogStarted()),
      expect: () => <CatalogState>[
        CatalogLoading(),
        CatalogError(),
      ],
      verify: (_) => verify(shoppingRepository.loadCatalog).called(1),
    );
  });
}
