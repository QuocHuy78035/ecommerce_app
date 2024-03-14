import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  final List _bannerImage = [];

  getBanner() {
    return _fireStore
        .collection("banners")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          _bannerImage.add(element['image']);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 140,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.yellow.shade900,
          borderRadius: BorderRadius.circular(10)),
      child: PageView.builder(
        itemCount: _bannerImage.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: "${_bannerImage[index]}",
              fit: BoxFit.fill,
              placeholder: (context, url) => Shimmer(
                duration: const Duration(seconds: 3),
                interval: const Duration(seconds: 5),
                color: Colors.white,
                colorOpacity: 0,
                enabled: true,
                direction: const ShimmerDirection.fromLBRT(),
                child: Container(
                  color: Colors.purple,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
