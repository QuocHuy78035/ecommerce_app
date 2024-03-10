import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.yellow.shade900,
        borderRadius: BorderRadius.circular(10)
      ),
      child: PageView(
        children: [
          Text("Banner 1"),
          Text("Banner 2"),
          Text("Banner 3"),
        ],
      ),
    );
  }
}
