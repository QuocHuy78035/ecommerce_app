import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/inner_screen/edit_profile_screen.dart';
import 'package:ecomerce_app/buyers/views/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../providers/cart_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    final CollectionReference users =
        FirebaseFirestore.instance.collection('buyers');
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Checkout"),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartItem().length,
              itemBuilder: (context, index) {
                final cartData =
                    cartProvider.getCartItem().values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 170,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl[0]),
                        ),
                        Column(
                          children: [
                            Text(cartData.productName),
                            Text(
                              cartData.price.toString(),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              child: Text(cartData.productSize),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomSheet: data['address'] == ""
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(userData: data,),
                        ),
                      );
                    },
                    child: const Text("Enter Address"))
                : GestureDetector(
                    onTap: () {
                      EasyLoading.show(status: "Placing Order");
                      cartProvider.getCartItem().forEach((key, value) {
                        final orderId = const Uuid().v4();
                        _fireStore.collection("orders").doc(orderId).set({
                          'orderId': orderId,
                          'vendor': value.vendorId,
                          'email': data['email'],
                          'phone': data['phoneNumber'],
                          'address': data['address'],
                          'buyerId': data['buyerId'],
                          'fullName': data['fullName'],
                          'productName': value.productName,
                          'productPrice': value.price,
                          'productImage': value.imageUrl,
                          'quantity': value.quantity,
                          "productSize": value.productSize,
                          "scheduleDate": value.scheduleDate,
                          "orderDate": DateTime.now(),
                          "accepted" : false,
                        }).whenComplete(() {
                          setState(() {
                            cartProvider.getCartItem().clear();
                          });
                          EasyLoading.dismiss();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainCustomerScreen(),
                            ),
                          );
                        });
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: const Center(
                        child: Text("Place Order"),
                      ),
                    ),
                  ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
