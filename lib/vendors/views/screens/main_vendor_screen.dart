import 'package:ecomerce_app/vendors/views/screens/upload_tap_screens/edit_product_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/vendor_earning_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/vendor_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {

  int _pageIndex = 0;

  final List<Widget> _pages = [
    const VendorEarningScreen(),
    const VendorUploadScreen(),
    const EditProductScreen(),
    Text("ORDERS"),
    Text("LOGOUT"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.yellow.shade900,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on_outlined),
            label: "EARNINGS",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "UPLOAD",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "EDIT",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/cart.svg"),
            label: "ORDERS",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: "LOGOUT",
          ),
        ],
      ),
    );
  }
}
