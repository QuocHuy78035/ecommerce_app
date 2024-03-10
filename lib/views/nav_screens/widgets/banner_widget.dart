import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  List _bannerImage = [];

  getBanner(){
    return _fireStore.collection("banners").get().then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          _bannerImage.add(element['image']);
        });
      }
    });
  }

  @override
  void initState(){
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
        borderRadius: BorderRadius.circular(10)
      ),
      child: PageView.builder(
          itemCount: _bannerImage.length,
          itemBuilder: (context, index){
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("${_bannerImage[index]}", fit: BoxFit.fill,),
            );
      })
    );
  }
}
