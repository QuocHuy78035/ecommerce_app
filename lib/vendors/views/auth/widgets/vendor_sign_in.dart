import 'package:ecomerce_app/vendors/views/auth/widgets/textfield_custom.dart';
import 'package:ecomerce_app/vendors/views/auth/widgets/vendor_register_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../utils/show_snackbar.dart';
import '../../../controllers/vendor_controller.dart';
import '../../screens/landing_screen.dart';

class VendorSignIn extends StatelessWidget {
  const VendorSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    final VendorController controller = VendorController();
    String email = '';
    String pass = '';
    final GlobalKey<FormState> key = GlobalKey<FormState>();

    signInVendor(String email, String pass) async {
      //if (key.currentState?.validate() != null) {
      EasyLoading.show(status: "Please wait");
      String res = await controller.vendorLogin(email, pass);
      print("123 $res");

      if (res == "Success") {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LandingScreen(),
          ),
        );
        return showSnackBar(context, "Login Success");
      } else {
        return showSnackBar(context, "Login Fail");
      }
      //}
    }

    return Scaffold(
      body: Form(
        //key: key,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'VENDOR SIGN IN',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Don\'t have Account?',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VendorRegisterAccount(),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.yellow.shade900,
                      ),
                    ),
                  ),
                ],
              ),
              TextFieldCustom(
                validator: (value) =>
                    value!.isEmpty ? "Field Cannot Empty" : null,
                hintText: 'Email',
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                isPass: true,
                validator: (value) =>
                    value!.isEmpty ? "Field Cannot Empty" : null,
                hintText: 'Password',
                onChanged: (value) {
                  pass = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Forgot password?'),
                    onPressed: () {},
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  onPressed: () {
                    signInVendor(email, pass);
                  },
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
