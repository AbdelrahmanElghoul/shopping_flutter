import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/cart_provider.dart';
import 'package:shop_app/ui/cart_page.dart';
import 'package:shop_app/util/style/colors.dart';
import 'package:shop_app/util/widgets/app_drawer.dart';
import 'package:shop_app/util/widgets/badge.dart';
import 'package:shop_app/util/widgets/items_grid.dart';

enum FilterOptions { Favourite, All }

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<ProductsModel>(context, listen: false);
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: appBar,
      drawer: AppDrawer(),
      body: ItemGrid(
        showFavourite: _showFavourites,
      ),
    );
  }

  void showFavourite(bool showFavs) {
    setState(() {
      _showFavourites = false;
    });
  }

  AppBar get appBar => AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print('mDebug: menu selected value = $value');
              switch (value) {
                case FilterOptions.Favourite:
                  print('mDebug: switch fav');
                  // product.showFavourite();
                  _showFavourites = true;
                  break;
                default:
                  // product.showAll();
                  _showFavourites = false;
                  break;
              }
              setState(() {});
            },
            icon: Icon(
              Icons.more_vert_outlined,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('favourite'),
                value: FilterOptions.Favourite,
              ),
              PopupMenuItem(
                child: Text('show all'),
                value: FilterOptions.All,
              ),
              // PopupMenuItem(
              //   value: 'nested item',
              //   child: PopupMenuButton(
              //       onSelected: (value2) {
              //         print('mDebug: menu2 value = $value2');
              //       },
              //       icon: Icon(Icons.arrow_left, color: Colors.red),
              //       itemBuilder: (_) => [
              //             PopupMenuItem(
              //               child: Text('x'),
              //               value: 'x',
              //             ),
              //           ]),
              // )
            ],
          ),
          Consumer<CartModel>(
            builder: (ctx, model, child) => Badge(
              child: child,
              value: model.items.length.toString(),
              color: Colors.red,
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(
                CartScreen.routeName,
              ),
            ),
          ),
        ],
        title: Text('Shop app'),
      );
}
