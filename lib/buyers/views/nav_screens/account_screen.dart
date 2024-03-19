import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/buyers/views/auth/login_screen.dart';
import 'package:ecomerce_app/buyers/views/inner_screen/edit_profile_screen.dart';
import 'package:ecomerce_app/buyers/views/nav_screens/widgets/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return firebaseAuth.currentUser?.uid != null
        ? FutureBuilder<DocumentSnapshot>(
            future: users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data?.data() as Map<String, dynamic>;
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                userData: data,
                              ),
                            ),
                          );
                        },
                        child: const Text("Edit Profile"),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const OrderScreen(),
                                  ),
                                );
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.shopping_cart),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Cart")
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
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
          )
        : Scaffold(
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
                  backgroundColor: Colors.yellow.shade900,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                const Text("Login to continue shopping"),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10)),
                    height: 40,
                    width: 200,
                    child: const Center(
                      child: Text(
                        "login",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
