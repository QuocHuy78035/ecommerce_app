import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/detail_products/detail_product_screen.dart';
import 'package:flutter/material.dart';

class AllProductScreen extends StatelessWidget {
  final dynamic cateData;

  const AllProductScreen({super.key, required this.cateData});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: cateData['categoryName'])
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(cateData['categoryName']),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return GridView.builder(
            itemCount: snapshot.data?.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 2 / 3),
            itemBuilder: (context, index) {
              final productData = snapshot.data?.docs[index];
              return SizedBox(
                height: 270,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailProductScreen(
                          productData: productData,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          height: 170,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                productData?['imageUrl'][0],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Text(
                          productData?['productName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 4,
                          ),
                        ),
                        Text("${productData?['productPrice']}")
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
