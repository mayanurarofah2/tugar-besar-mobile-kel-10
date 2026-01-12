import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String image;
  final int price;
  int qty;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.qty = 1,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> cart = [];

  void addToCart(dynamic p) {
    try {
      final exist = cart.firstWhere((c) => c.name == p["name"]);
      exist.qty++;
    } catch (e) {
      cart.add(
        CartItem(
          name: p["name"],
          image: p["image"], // penting: asset bukan URL
          price: p["price"],
        ),
      );
    }
    notifyListeners();
  }

  void increaseQty(CartItem item) {
    item.qty++;
    notifyListeners();
  }

  void decreaseQty(CartItem item) {
    if (item.qty > 1) {
      item.qty--;
    } else {
      cart.remove(item);
    }
    notifyListeners();
  }

  int get totalPrice =>
      cart.fold(0, (sum, item) => sum + (item.qty * item.price));

  // ✅ TAMBAHAN SAJA (UNTUK CHECKOUT)
  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
