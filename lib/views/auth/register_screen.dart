import 'package:ecomerce_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final AuthController authController = AuthController();
  late String email = '';
  late String fullName = '';
  late String phoneNumber = '';
  late String password = '';

  signupUser() async {
    String res = await authController.signUpUser(
      email,
      fullName,
      phoneNumber,
      password,
    );
    if(res != "Create account success"){
      print(res);
    }else{
      print("Suc");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                onChanged: (value){
                  email = value;
                },
                decoration: const InputDecoration(hintText: "Enter Email"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value){
                  fullName = value;
                },
                decoration: const InputDecoration(hintText: "Enter Full Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value){
                  phoneNumber = value;
                },
                decoration:
                    const InputDecoration(hintText: "Enter Phone Number"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value){
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
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    signupUser();
                  },
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                      letterSpacing: 4,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
