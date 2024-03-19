import 'package:ecomerce_app/vendors/views/auth/widgets/vendor_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorLogoutScreen extends StatelessWidget {
  const VendorLogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Out"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            ElevatedButton(
              onPressed: () async {
              FirebaseAuth.instance.currentUser?.uid;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VendorSignIn(),
                ),
              );
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
