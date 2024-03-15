import 'package:ecomerce_app/buyers/views/auth/register_screen.dart';
import 'package:ecomerce_app/buyers/views/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../utils/show_snackbar.dart';
import '../../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = AuthController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late String email = '';
  late String pass = '';
  bool isLoading = false;

  loginsUser() async {
    if (_key.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String res = await authController.loginUser(email, pass).whenComplete((){
        setState(() {
          isLoading = false;
        });
      });
      if (res != "Login Success") {
        return showSnackBar(context, "Login Fail");
      } else {
        showSnackBar(context, res);
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainCustomerScreen(),
          ),
        );
      }
    } else {
      return showSnackBar(context, "Please fill all field");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Customer's Account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot empty";
                  } else {
                    return null;
                  }
                },
                decoration:
                    const InputDecoration(hintText: "Enter Email Address"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (value) {
                  pass = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Pass cannot empty";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(hintText: "Enter Password"),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade900,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    loginsUser();
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Don't have account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuyerRegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.yellow.shade900, fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
