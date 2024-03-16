import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:ecomerce_app/vendors/views/screens/main_vendor_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/attributes_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/general_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/image_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class VendorUploadScreen extends StatefulWidget {
  const VendorUploadScreen({super.key});

  @override
  State<VendorUploadScreen> createState() => _VendorUploadScreenState();
}

class _VendorUploadScreenState extends State<VendorUploadScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "General",
                ),
              ),
              Tab(
                child: Text(
                  "Shipping",
                ),
              ),
              Tab(
                child: Text(
                  "Attributes",
                ),
              ),
              Tab(
                child: Text(
                  "Images",
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributeScreen(),
            ImageScreen()
          ],
        ),
        bottomSheet: ElevatedButton(
          onPressed: () async {
            EasyLoading.show(status: "Uploading...");
            final productId = const Uuid().v4();
            await _fireStore.collection("products").doc(productId).set({
              'productId': productId,
              'productName': _productProvider.productData['productName'],
              "productPrice": _productProvider.productData['productPrice'],
              "quantity": _productProvider.productData['quantity'],
              "category": _productProvider.productData['category'],
              "description": _productProvider.productData['description'],
              "imageUrl": _productProvider.productData['imageUrlList'],
              "scheduleDate": _productProvider.productData['scheduleDate'],
              "chargeShipping": _productProvider.productData['chargeShipping'],
              "shippingCharge": _productProvider.productData['shippingCharge'],
              "brandName": _productProvider.productData['brandName'],
              "sizeList": _productProvider.productData['listSize'],
              "vendorId" : FirebaseAuth.instance.currentUser?.uid,
              "approved": false,
            }).whenComplete(
              () {
                EasyLoading.dismiss();
                _productProvider.clearData();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainVendorScreen(),
                  ),
                );
              },
            );
          },
          child: const Text("Save"),
        ),
      ),
    );
  }
}
