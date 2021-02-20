import 'package:flutter/cupertino.dart';
import 'package:shop_app/core/models/cart.dart';

class CartModel with ChangeNotifier {
  // List<CartItem>
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) => total += (value.price * value.quantity));
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void addItem(
    String productId,
    String title,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (i) => CartItem(
                id: i.id,
                title: i.title,
                quantity: i.quantity + 1,
                price: i.price,
              ));
    } else {
      CartItem cart = CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1);

      _items.putIfAbsent(productId, () => cart);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
