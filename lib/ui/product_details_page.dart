import 'package:flutter/material.dart';

import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/util/widgets/app_drawer.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({this.product});
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    // Product product = Provider.of<Product>(context, listen: false);
    return Scaffold(  drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('${product.title}'),
        ),
        body: SingleChildScrollView(child: productDetails(mediaQuery)));
  }

  Widget productDetails(MediaQueryData mediaQuery) => Column(
        children: [
          Container(
            height: mediaQuery.size.height * .4,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '\$${product.price}',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              product.description,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ],
      );
}
