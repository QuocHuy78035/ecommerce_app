import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (!snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data['fullName']);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow.shade900,
              elevation: 2,
              title: const Text(
                "Profile",
                style: TextStyle(
                  letterSpacing: 4,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(14),
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(data['profileImage']),
                  backgroundColor: Colors.yellow.shade900,
                ),
                Text(data['fullName']),
                Text(data['email']),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Setting")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Phone")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Icon(Icons.shopping_cart),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Cart")
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          print("123");
                          EasyLoading.show();
                          firebaseAuth.signOut().whenComplete(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                            EasyLoading.dismiss();
                          });
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.logout_outlined),
                            SizedBox(
                              width: 20,
                            ),
                            Text("Log out")
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
