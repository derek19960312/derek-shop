import 'package:equatable/equatable.dart';

import 'item.dart';

class Catalog extends Equatable {
  const Catalog({required this.items});

  final List<Item> items;

  Item getByPosition(int position) => items[position];


  @override
  List<Object> get props => [items];
}
