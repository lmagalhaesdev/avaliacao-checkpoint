import 'package:app/src/models/product.dart';

class CartItem {
  final ProductModel product;
  int quantity;
  String size;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.size = 'M',
  });

  double get totalPrice => product.price * quantity;
}
