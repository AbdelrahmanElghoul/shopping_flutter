import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/products_provider.dart';
import 'package:shop_app/ui/edit_product_page.dart';
import 'package:shop_app/util/widgets/app_drawer.dart';
import 'package:shop_app/util/widgets/user_product.dart';

class UserProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsModel>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('User Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => EditProductPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productData.productList.length,
          itemBuilder: (_, index) => Column(
            children: [
              UserProductWidget(
                product: productData.productList[index],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
