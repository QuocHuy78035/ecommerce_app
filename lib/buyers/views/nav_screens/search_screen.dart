import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/detail_products/detail_product_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Stream<QuerySnapshot> _searchStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  String searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: TextFormField(
          // onChanged: (value){
          //   searchValue = value;
          // },
          onFieldSubmitted: (value) {
            setState(() {
              searchValue = value;
            });
          },
          decoration: const InputDecoration(
              hintText: "Search products", suffixIcon: Icon(Icons.search)),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _searchStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          final searchedData = snapshot.data?.docs.where((element) {
            return element['productName']
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          });
          return searchValue == ""
              ? const Text("Search Products")
              : SingleChildScrollView(
                  child: Column(
                    children: searchedData!.map(
                      (e) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailProductScreen(productData: e),
                              ),
                            );
                          },
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.network(e['imageUrl'][0]),
                                ),
                                Column(
                                  children: [Text(e['productName'])],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                );
        },
      ),
    );
  }
}
