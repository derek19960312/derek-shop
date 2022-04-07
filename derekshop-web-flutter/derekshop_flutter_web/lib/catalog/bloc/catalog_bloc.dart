import 'package:bloc/bloc.dart';
import 'package:derekshop_flutter_web/catalog/models/catalog.dart';
import 'package:derekshop_flutter_web/locator.dart';
import 'package:derekshop_flutter_web/shopping_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required this.shoppingRepository}) : super(CatalogLoading()) {
    on<CatalogStarted>(_onStarted);
  }

  final ShoppingRepository shoppingRepository;

  void _onStarted(CatalogStarted event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    try {
      final catalog = await shoppingRepository.loadCatalog();
      emit(CatalogLoaded(Catalog(items: catalog)));
    } catch (_) {
      locator<Logger>().e(_);
      emit(CatalogError());
    }
  }
}
