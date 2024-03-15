import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailProductScreen extends StatefulWidget {
  final dynamic productData;

  const DetailProductScreen({super.key, required this.productData});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.productData['productName']),
        ),
        body: Stack(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PhotoView(
                imageProvider: NetworkImage(widget.productData['imageUrl'][_imageIndex]),
              ),
            ),
            Positioned(
              bottom: 0,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productData['imageUrl'].length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _imageIndex = index;
                          });
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: Image.network(widget.productData['imageUrl'][index]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }
}
