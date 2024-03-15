import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

class DetailProductScreen extends StatefulWidget {
  final dynamic productData;

  const DetailProductScreen({super.key, required this.productData});

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  int _imageIndex = 0;

  format(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  String _selectedSize = '';
  List<Color> bgColor = [Colors.white];

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(
        context, listen: false);
    Timestamp timestamp = widget.productData['scheduleDate'];
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    String formattedDate = format(dateTime);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: PhotoView(
                  imageProvider:
                  NetworkImage(widget.productData['imageUrl'][_imageIndex]),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.productData['imageUrl'].length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _imageIndex = index;
                            });
                          },
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.network(
                                widget.productData['imageUrl'][index]),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text("${widget.productData['productPrice']}"),
          Text(
            "${widget.productData['productName']}",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 8),
          ),
          ExpansionTile(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Product Description",
                ),
                Text(
                  "View More",
                ),
              ],
            ),
            children: [Text(widget.productData['description'])],
          ),
          Text("The product will be shipping on $formattedDate"),
          ExpansionTile(
            title: const Text("Available Size"),
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.productData['sizeList'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedSize =
                            widget.productData['sizeList'][index];
                          });
                        },
                        child: Text(widget.productData['sizeList'][index]),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          cartProvider.addProductToCart(
            widget.productData['productName'],
            widget.productData['productId'],
            widget.productData['imageUrl'],
            1,
            //widget.productData['quantity'],
            widget.productData['productPrice'],
            widget.productData['vendorId'],
            _selectedSize,
            widget.productData['scheduleDate'],
          );
          print('object');
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.yellow.shade900),
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: 50,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Add To Cart",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 8,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
