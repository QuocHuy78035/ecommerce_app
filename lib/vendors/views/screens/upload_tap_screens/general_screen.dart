import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final List _categoryList = [];

  getCategory() {
    return _fireStore
        .collection("categories")
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var element in querySnapshot.docs) {
        setState(() {
          _categoryList.add(element['categoryName']);
        });
      }
    });
  }

  String formatDate(date) {
    final outputDateFormat = DateFormat('dd/MM/yyy');
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvide =
        Provider.of<ProductProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                _productProvide.getFormData(productName: value);
              },
              decoration: const InputDecoration(hintText: "Enter Product Name"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                _productProvide.getFormData(
                  productPrice: double.parse(value),
                );
              },
              decoration:
                  const InputDecoration(hintText: "Enter Product Price"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                _productProvide.getFormData(
                  quantity: int.parse(value),
                );
              },
              decoration:
                  const InputDecoration(hintText: "Enter Product Quantity"),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              hint: const Text("Select Category"),
              items: _categoryList.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem(value: e, child: Text(e));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _productProvide.getFormData(category: value);
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 5,
              maxLength: 800,
              onChanged: (value) {
                _productProvide.getFormData(description: value);
              },
              decoration: InputDecoration(
                labelText: "Enter Product Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(5000),
                    ).then((value) {
                      setState(() {
                        _productProvide.getFormData(scheduleDate: value);
                      });
                    });
                  },
                  child: const Text("Schedule"),
                ),
                if (_productProvide.productData['scheduleDate'] != null)
                  Text(
                    formatDate(
                      _productProvide.productData['scheduleDate'],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
