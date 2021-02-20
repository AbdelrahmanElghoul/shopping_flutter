import 'package:flutter/material.dart';
import 'package:shop_app/core/models/cart.dart';
import 'package:shop_app/core/models/order.dart';

class OrdersModel with ChangeNotifier {
  List<Order> _orderList = [];
  List<Order> get orderList => [..._orderList];

  addOrder(List<CartItem> cartList, double total) {
    _orderList.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        itemList: cartList,
        amount: total,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
