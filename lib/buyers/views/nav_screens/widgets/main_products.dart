import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/detail_products/detail_product_screen.dart';
import 'package:flutter/material.dart';

class MainProductScreen extends StatefulWidget {

  const MainProductScreen({super.key, });

  @override
  State<MainProductScreen> createState() => _MainProductScreenState();
}

class _MainProductScreenState extends State<MainProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final productData = snapshot.data?.docs[index];
              return GestureDetector(
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
              );
            },
            separatorBuilder: (context, _) {
              return const SizedBox(
                width: 15,
              );
            },
            itemCount: snapshot.data!.docs.length,
          ),
        );
      },
    );
  }
}