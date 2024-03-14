import 'package:ecomerce_app/buyers/views/nav_screens/widgets/banner_widget.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/category_text.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/search_input_widget.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/welcome_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WelcomeText(),
        SizedBox(
          height: 14,
        ),
        SearchInputWidget(),
        BannerWidget(),
        CategoryText()
      ],
    );
  }
}

