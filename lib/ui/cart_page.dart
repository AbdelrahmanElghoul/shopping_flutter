import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/cart_provider.dart';
import 'package:shop_app/core/providers/orders_provider.dart';
import 'package:shop_app/util/widgets/app_drawer.dart';
import 'package:shop_app/util/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          totalCard(context),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (_, index) => CartItemWidget(
                productId: cart.items.keys.elementAt(index),
                item: cart.items.values.elementAt(index),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget totalCard(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Spacer(),
            Chip(
              backgroundColor: Theme.of(context).primaryColorLight,
              label: Text(
                '\$${cart.totalAmount.toStringAsFixed(2)}',
              ),
              // avatar: Icon(Icons.money),
              // deleteButtonTooltipMessage: "deleteButtonTooltipMessage",
              // deleteIcon: Icon(
              //   Icons.close,
              //   color: Colors.red,
              // ),
              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // onDeleted: () {
              //   print('mDebug: onDelete');
              // },
            ),
            FlatButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                if (cart.items.values.length == 0) return;
                Provider.of<OrdersModel>(context, listen: false).addOrder(
                  cart.items.values.toList(),
                  cart.totalAmount,
                );

                cart.clearCart();
              },
              child: Text(
                'Order now',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
