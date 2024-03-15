import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/models/cartatb_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttrb> _cartItems = {};

  Map<String, CartAttrb> getCartItem() {
    return _cartItems;
  }

  void addProductToCart(
      String productName,
      String productId,
      List imageUrl,
      int quantity,
      double price,
      String vendorId,
      String productSize,
      Timestamp scheduleDate) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (value) => CartAttrb(
          productName: value.productName,
          productId: value.productId,
          imageUrl: value.imageUrl,
          quantity: value.quantity + 1,
          price: value.price,
          vendorId: value.vendorId,
          productSize: value.productSize,
          scheduleDate: value.scheduleDate,
        ),
      );
      notifyListeners();
    } else {
      _cartItems.update(
        productId,
        (value) => CartAttrb(
          productName: productName,
          productId: productId,
          imageUrl: imageUrl,
          quantity: quantity,
          price: price,
          vendorId: vendorId,
          productSize: productSize,
          scheduleDate: scheduleDate,
        ),
      );
      notifyListeners();
    }
  }
}
