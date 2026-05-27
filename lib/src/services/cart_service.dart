import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartService with ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];
  double _shippingCost = 0.0;
  double _discount = 0.0;

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get shippingCost => _shippingCost;
  double get discount => _discount;

  double get finalTotal => (totalAmount + _shippingCost - _discount).clamp(0.0, double.infinity);

  void setShippingCost(double cost) {
    _shippingCost = cost;
    notifyListeners();
  }

  void applyCoupon(String code) {
    if (code.toUpperCase() == "ALURA10") {
      _discount = totalAmount * 0.1;
    } else {
      _discount = 0.0;
    }
    notifyListeners();
  }

  void addToCart(ProductModel product, {int quantity = 1, String size = 'M'}) {
    final index = _items.indexWhere((item) => 
      item.product.id == product.id && item.size == size
    );

    if (index >= 0) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product, 
        quantity: quantity, 
        size: size,
      ));
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void updateSize(int productId, String size) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].size = size;
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _shippingCost = 0.0;
    _discount = 0.0;
    notifyListeners();
  }
}
