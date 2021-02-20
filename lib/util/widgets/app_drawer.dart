import 'package:flutter/material.dart';
import 'package:shop_app/ui/order_page.dart';
import 'package:shop_app/ui/products_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        // color: Colors.red,
        child: Column(
      children: [
        AppBar(
          title: Text('Welcome'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        drawerItem(
          context,
          leadingIcon: Icons.shop,
          title: 'Shop',
          navTo: ProductScreen(),
        ),
        drawerItem(
          context,
          leadingIcon: Icons.payment,
          title: 'Orders',
          navTo: OrderPage(),
        ),
      ],
    ));
  }

  Widget drawerItem(context,
      {IconData leadingIcon, String title, Widget navTo}) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      onTap: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => navTo,
        ),
      ),
    );
  }
}
