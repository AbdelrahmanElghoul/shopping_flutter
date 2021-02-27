import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/models/cart.dart';
import 'package:shop_app/core/providers/cart_provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final String productId;
  CartItemWidget({@required this.productId, @required this.item});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Dismissible(
        key: ValueKey(item.id),
        background: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.centerRight,
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          Provider.of<CartModel>(context, listen: false).removeItem(productId);
        },
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (c) => AlertDialog(
              title: Text('Are you sure ?'),
              content: Text('Do you want to remove the item from the cart'),
              actions: [
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(c, false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(c, true);
                  },
                ),
              ],
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(
                  child: Text(
                    '\$${item.price}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            title: Text('${item.title}'),
            subtitle: Text('Total:${(item.price * item.quantity)}'),
            trailing: Text('x${item.quantity}'),
          ),
        ),
      ),
    );
  }
}
