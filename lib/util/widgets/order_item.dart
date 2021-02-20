import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/core/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem({@required this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expand = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(expand ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  expand = !expand;
                });
              },
            ),
          ),
          if (expand)
            Container(
              padding: const EdgeInsets.all(10),
              height:
                  min(widget.order.itemList.length.toDouble() * 10 + 60, 180),
              child: ListView.builder(
                itemCount: widget.order.itemList.length,
                itemBuilder: (_, index) => orderItemWiget(index),
              ),
            ),
        ],
      ),
    );
  }

  Widget orderItemWiget(int index) {
    return Row(
      children: [
        Text(
          widget.order.itemList[index].title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Spacer(),
        Text(
          '${widget.order.itemList[index].quantity}x \$${widget.order.itemList[index].price}',
          style: TextStyle(
            fontSize: 17,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
