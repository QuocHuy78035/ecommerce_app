import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartAttrb with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrl;
  int quantity;
  final int productQuantity;
  final double price;
  final String vendorId;
  final String productSize;
  final Timestamp scheduleDate;

  CartAttrb({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.productQuantity,
    required this.price,
    required this.vendorId,
    required this.productSize,
  required this.scheduleDate});

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }
}
