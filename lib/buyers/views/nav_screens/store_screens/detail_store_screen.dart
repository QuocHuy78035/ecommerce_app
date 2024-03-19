import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailStoreScreen extends StatefulWidget {
  final dynamic storeData;

  const DetailStoreScreen({super.key, this.storeData});

  @override
  State<DetailStoreScreen> createState() => _DetailStoreScreenState();
}

class _DetailStoreScreenState extends State<DetailStoreScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storesStream = FirebaseFirestore.instance
        .collection('products')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeData['businessName']),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _storesStream,
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
          );
        },
      ),
    );
  }
}
