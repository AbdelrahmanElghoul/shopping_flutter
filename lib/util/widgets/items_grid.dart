import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/products_provider.dart';
import 'package:shop_app/util/widgets/product_item_widget.dart';

class ItemGrid extends StatelessWidget {
  final bool showFavourite;
  ItemGrid({this.showFavourite = false});
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsModel>(context);
    final products = showFavourite
        ? productsData.favouriteProducts
        : productsData.productList;
    final mediaQuery = MediaQuery.of(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate:
          // SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
        maxCrossAxisExtent: mediaQuery.size.width / 2,
      ),
      itemCount: products.length ?? 0,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: products[index],
          builder: (c, _) => ProductItemWIdget(
              // product: productsData.productList[index],
              )),
      // ProductItemWIdget(
      //   product: Provider.of<ProductsModel>(context).productList[index],
      // ),
    );
  }
}
