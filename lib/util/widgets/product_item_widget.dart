import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/models/product.dart';
import 'package:shop_app/core/providers/cart_provider.dart';
import 'package:shop_app/ui/product_details_page.dart';
import 'package:shop_app/util/style/colors.dart';

class ProductItemWIdget extends StatelessWidget {
  // final Product product;
  // ProductItemWIdget({this.product});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<CartModel>(context, listen: false);
    return InkResponse(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductDetailScreen(product: product),
        )
            //  ProductDetailScreen(
            //     // productId: product.id,
            //     ),

            );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (_, product, __) => IconButton(
                onPressed: () => product.toggleFavourite(),
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: product.isFavourite
                      ? Colors.red
                      : AppColors.primaryIconColor,
                ),
              ),
            ),
            backgroundColor: Colors.black45,
            title: Text(
              '${product.title}',
              textAlign: TextAlign.center,
            ),
            // subtitle: Text('2'),
            trailing: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: AppColors.primaryIconColor,
                ),
                color: AppColors.primaryAccent,
                onPressed: () {
                  cart.addItem(product.id, product.title, product.price);
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    // backgroundColor: Theme.of(context).primaryColor,
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('added to cart'),
                      ],
                    ),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ));
                }),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
