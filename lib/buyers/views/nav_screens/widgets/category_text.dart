import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/home_product.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/main_products.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String _selectCategory = '';
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(fontSize: 19),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          final cateData = snapshot.data?.docs[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                            child: ActionChip(
                              backgroundColor: Colors.yellow.shade900,
                              onPressed: () {
                                setState(() {
                                  _selectCategory = cateData?['categoryName'];
                                });
                              },
                              label: Center(
                                child: Text(
                                  cateData?['categoryName'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.navigate_next,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          if(_selectCategory == "")
            const MainProductScreen(),
          if(_selectCategory != "")
            HomeProductScreen(categoryName: _selectCategory)
        ],
      ),
    );
  }
}
