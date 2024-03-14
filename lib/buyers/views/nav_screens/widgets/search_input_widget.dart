import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            hintText: "Search for products",
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(
                "assets/icons/search.svg",
                width: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
