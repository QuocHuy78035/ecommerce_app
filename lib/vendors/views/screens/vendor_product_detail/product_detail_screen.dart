import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({super.key, required this.productData});

  @override
  State<VendorProductDetailScreen> createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int? quantity;
  double? price;

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.productData['productName'];
    _brandNameController.text = widget.productData['brandName'];
    _quantityController.text = widget.productData['quantity'].toString();
    _productPriceController.text =
        widget.productData['productPrice'].toString();
    _descriptionController.text = widget.productData['productName'];
    _categoryController.text = widget.productData['category'];
    quantity = int.parse(_quantityController.text);
    price = double.parse(_productPriceController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(hintText: "Product Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _brandNameController,
                decoration: const InputDecoration(hintText: "Brand Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value){
                  quantity = int.parse(value);
                },
                controller: _quantityController,
                decoration: const InputDecoration(hintText: "Quantity"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value){
                  price = double.parse(value);
                },
                controller: _productPriceController,
                decoration: const InputDecoration(hintText: "Product Price"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _descriptionController,
                maxLength: 400,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(hintText: "Category"),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: ()async{
          EasyLoading.show();
          await _firestore.collection("products").doc(widget.productData['productId']).update({
            'productName' : _productNameController.text,
            'brandName' : _brandNameController.text,
            'quantity' : quantity,
            'productPrice' : price,
            'description' : _descriptionController.text,
            'category' : _categoryController.text,
          }).whenComplete(() => EasyLoading.dismiss());
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow.shade900
          ),
          child: const Center(
            child: Text(
              "Update Product",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
