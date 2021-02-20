
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/orders_provider.dart';
import 'package:shop_app/util/widgets/app_drawer.dart';
import 'package:shop_app/util/widgets/order_item.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersModel>(context);
    return Scaffold(  drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.orderList.length,
        itemBuilder: (_, index) => OrderItem(
          order: orders.orderList[index],
        ),
      ),
    );
  }
}
