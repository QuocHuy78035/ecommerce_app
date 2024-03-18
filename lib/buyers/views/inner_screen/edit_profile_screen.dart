import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;
  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String address = '';

  @override
  void initState(){
    super.initState();
    _emailController.text = widget.userData['email'];
    _fullNameController.text = widget.userData['fullName'];
    _phoneNumberController.text = widget.userData['phoneNumber'];
    _addressController.text = widget.userData['address'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.yellow.shade900,
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.photo_camera_outlined),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  hintText: "Enter Full Name"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "Enter Email"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                    hintText: "Enter Phone Number"
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(

                onChanged: (value){
                  address = value;
                },
                controller: _addressController,
                decoration: const InputDecoration(
                    hintText: "Enter Address"
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        onTap: () async{
          EasyLoading.show(status: "Updating");
          await _firestore.collection("buyers").doc(FirebaseAuth.instance.currentUser?.uid).update({
            'fullName' : _fullNameController.text,
            'address' : address,
            'phoneNumber' : _phoneNumberController.text,
            'email' : _emailController.text
          }).whenComplete((){
            EasyLoading.dismiss();
            Navigator.pop(context);
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration:  BoxDecoration(
            color: Colors.yellow.shade900,
            borderRadius: BorderRadius.circular(10)
          ),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: const Center(
            child: Text("Update"),
          ),
        ),
      ),
    );
  }
}
