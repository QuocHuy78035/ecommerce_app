import 'package:ecomerce_app/vendors/views/screens/edit_products_tabs/published_tab_screen.dart';
import 'package:ecomerce_app/vendors/views/screens/edit_products_tabs/unpublished_tab_screen.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          title: Text("Management Products"),
          bottom: TabBar(
            tabs: [
              Tab(child: Text("Published"),),
              Tab(child: Text("Unpublished"),)
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PublishedTabScreen(),
            UnPublishedTabScreen()
          ],
        ),
      ),
    );
  }
}
