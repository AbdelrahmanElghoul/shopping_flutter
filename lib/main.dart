import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/providers/cart_provider.dart';
import 'package:shop_app/core/providers/orders_provider.dart';
import 'package:shop_app/core/providers/products_provider.dart';
import 'package:shop_app/ui/cart_page.dart';
import 'package:shop_app/ui/products_page.dart';
import 'package:shop_app/util/style/colors.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductsModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: AppColors.primarySwatch,
          accentColor: AppColors.primaryAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductScreen(),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
