import 'package:ecomerce_app/controllers/auth_controller.dart';
import 'package:ecomerce_app/utils/show_snackbar.dart';
import 'package:flutter/material.dart';

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

  signupUser() async {
   if(_key.currentState!.validate()){
     setState(() {
       isLoading = true;
     });
     String res = await authController.signUpUser(
       email,
       fullName,
       phoneNumber,
       password,
     ).whenComplete((){
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
       return showSnackBar(context, "Register Successfully!");
     }
   }else{

     return showSnackBar(context, "Please fill all field");
   }
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
                CircleAvatar(
                  backgroundColor: Colors.yellow.shade900,
                  radius: 64,
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
                    child: isLoading == false ? const Text(
                      "REGISTER",
                      style: TextStyle(
                        letterSpacing: 4,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ) : const CircularProgressIndicator(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
