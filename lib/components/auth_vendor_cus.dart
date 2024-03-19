import 'package:ecomerce_app/buyers/views/auth/login_screen.dart';
import 'package:ecomerce_app/vendors/views/auth/widgets/vendor_sign_in.dart';
import 'package:flutter/material.dart';

class MainVendorCustomerScreen extends StatelessWidget {
  const MainVendorCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text("Customer Login"),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VendorSignIn(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellow.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text("Vendor Login"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
