import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/models/cart.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> itemList;
  final DateTime dateTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.itemList,
    @required this.dateTime,
  });
}
