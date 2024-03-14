import 'dart:io';
import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker picker = ImagePicker();
  List<File> _image = [];
  late List<String> _imageUrl = [];

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) {
      print("No image pick");
    } else {
      setState(() {
        _image.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Column(
      children: [
        GridView.builder(
            shrinkWrap: true,
            itemCount: _image.length + 1,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 3 / 3),
            itemBuilder: (context, index) {
              return index == 0
                  ? Center(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          chooseImage();
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(_image[index - 1]))),
                    );
            }),
        _image.isNotEmpty ? TextButton(
          onPressed: () async {
            EasyLoading.show(status: "Saving image");
            for (var img in _image) {
              Reference ref =
                  _storage.ref().child("productImage").child(const Uuid().v4());
              await ref.putFile(img).whenComplete(
                () async {
                  await ref.getDownloadURL().then((value) {
                    setState(() {
                      _imageUrl.add(value);
                      productProvider.getFormData(imageUrlList: _imageUrl);
                      EasyLoading.dismiss();
                    });
                  });
                },
              );
            }
          },
          child: const Text("Upload"),
        ) : Container()
      ],
    );
  }
}
