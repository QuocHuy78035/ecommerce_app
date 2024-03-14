import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/attributes_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/general_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/image_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorUploadScreen extends StatelessWidget {
  const VendorUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context, listen: false);
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
          onPressed: (){
            print("${_productProvider.productData['productName']}");
            print("${_productProvider.productData['productPrice']}");
            print("${_productProvider.productData['quantity']}");
            print("${_productProvider.productData['category']}");
            print("${_productProvider.productData['description']}");
            print("${_productProvider.productData['imageUrlList']}");
          },
          child: Text("Save"),
        ),
      ),
    );
  }
}
