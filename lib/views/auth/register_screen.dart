import 'dart:io';

import 'dart:typed_data';
import 'package:ecomerce_app/controllers/auth_controller.dart';
import 'package:ecomerce_app/utils/show_snackbar.dart';
import 'package:ecomerce_app/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String email = '';
  late String fullName = '';
  late String phoneNumber = '';
  late String password = '';
  bool isLoading = false;
  File? selectedImage;

  signupUser() async {
    List<int> imageBytes = await selectedImage!.readAsBytes();
    Uint8List imageData = Uint8List.fromList(imageBytes);
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String res = await authController
          .signUpUser(
        email,
        fullName,
        phoneNumber,
        password,
          imageData
      )
          .whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
      if (res != "Create account success") {
        setState(() {
          _key.currentState?.reset();
        });
        return showSnackBar(context, "Register Failed!");
      } else {
        setState(() {
          _key.currentState?.reset();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
        return showSnackBar(context, "Register Successfully!");
      }
    } else {
      return showSnackBar(context, "Please fill all field");
    }
  }

  Future pickGalleryImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = File(returnedImage?.path ?? "");
    });
  }

  Future pickCameraImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      selectedImage = File(returnedImage?.path ?? "");
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Create Customer's Account",
                  style: TextStyle(fontSize: 20),
                ),
                Stack(
                  children: [
                    selectedImage == null
                        ? CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 64,
                            backgroundImage: const NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/ddnangcao-project"
                              ".appspot.com/o/users%2Fdefault.png?"
                              "alt=media&token=25343bf9-3975-4f6a-98ae-bec6f469c2b2",
                            ),
                          )
                        : CircleAvatar(
                            radius: 64,
                            backgroundImage: FileImage(
                              selectedImage!,
                            ),
                          ),
                    Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            pickGalleryImage();
                          },
                          child: const Icon(
                            Icons.image,
                            color: Colors.black,
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill Email";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: const InputDecoration(hintText: "Enter Email"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill Full Name";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    fullName = value;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter Full Name"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill Phone Number";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration:
                      const InputDecoration(hintText: "Enter Phone Number"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please fill Password";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: const InputDecoration(hintText: "Enter Password"),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      signupUser();
                    },
                    child: isLoading == false
                        ? const Text(
                            "REGISTER",
                            style: TextStyle(
                              letterSpacing: 4,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Already Have account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
