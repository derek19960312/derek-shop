import 'dart:core';

import 'package:equatable/equatable.dart';

class Item extends Equatable {

  const Item({required this.id, required this.name, required this.desc, required this.img, required this.payType, required this.dateTime, required this.price});

  final String id;
  final String name;
  final String desc;
  final String img;
  final String payType;
  final DateTime dateTime;
  final int price;

  @override
  List<Object> get props => [id, name, price];
}
