import 'package:ecomerce_app/buyers/views/nav_screens/account_screen.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/home_screen.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'nav_screens/cart_screen.dart';
import 'nav_screens/category_screen.dart';
import 'nav_screens/search_screen.dart';

class MainCustomerScreen extends StatefulWidget {
  const MainCustomerScreen({super.key});

  @override
  State<MainCustomerScreen> createState() => _MainCustomerScreenState();
}

class _MainCustomerScreenState extends State<MainCustomerScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoreScreen(),
    const CartScreen(),
    const SearchScreen(),
    const AccountScreen()
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
            icon: Icon(Icons.home),
            label: "HOME",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/explore.svg"),
            label: "CATEGORIES",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/shop.svg"),
            label: "STORE",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/cart.svg"),
            label: "CART",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            label: "SEARCH",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/icons/account.svg"),
            label: "PROFILE",
          ),
        ],
      ),
    );
  }
}
