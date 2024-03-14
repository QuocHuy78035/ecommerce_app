import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/attributes_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/general_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/image_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/shipping_screen.dart';
import 'package:flutter/material.dart';

class VendorUploadScreen extends StatelessWidget {
  const VendorUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
    );
  }
}
