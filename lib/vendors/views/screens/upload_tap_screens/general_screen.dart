import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Enter Product Name"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  const InputDecoration(hintText: "Enter Product Price"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
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
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 5,
              maxLength: 800,
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
                      );
                    },
                    child: const Text("Schedule"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
