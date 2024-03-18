import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/models/cartatb_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttrb> _cartItems = {};

  Map<String, CartAttrb> getCartItem() {
    return _cartItems;
  }

  double get totalPrice{
    var total = 0.0;
    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
      String productName,
      String productId,
      List imageUrl,
      int quantity,
      int price,
      String vendorId,
      String productSize,
      int productQuantity,
      Timestamp scheduleDate) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (value) => CartAttrb(
          productQuantity : value.productQuantity,
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
      _cartItems.putIfAbsent(
        productId,
        () => CartAttrb(
          productQuantity: productQuantity,
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

  void increment(CartAttrb cartAttrb){
    cartAttrb.increment();
    notifyListeners();
  }

  void decrement(CartAttrb cartAttrb){
    cartAttrb.decrement();
    notifyListeners();
  }

  void removeItem(String productId){
    _cartItems.remove(productId);
    notifyListeners();
  }

  void removeAllItem(){
    _cartItems.clear();
    notifyListeners();
  }
}
