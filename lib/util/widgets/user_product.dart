import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/providers/products_provider.dart';
import 'package:shop_app/ui/edit_product_page.dart';

class UserProductWidget extends StatelessWidget {
  final Product product;
  UserProductWidget({@required this.product});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProductPage(
                      id: product.id,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () =>
                  Provider.of<ProductsModel>(context, listen: false)
                      .deleteProduct(product.id),
            )
          ],
        ),
      ),
    );
  }
}
