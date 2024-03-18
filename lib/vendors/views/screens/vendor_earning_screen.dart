import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VendorEarningScreen extends StatefulWidget {
  const VendorEarningScreen({super.key});

  @override
  State<VendorEarningScreen> createState() => _VendorEarningScreenState();
}

class _VendorEarningScreenState extends State<VendorEarningScreen> {

  @override
  Widget build(BuildContext context) {
    CollectionReference vendors = FirebaseFirestore.instance.collection('vendors');
    final Stream<QuerySnapshot> _vendorsStream = FirebaseFirestore.instance.collection('orders').snapshots();


    return FutureBuilder<DocumentSnapshot>(
      future: vendors.doc(FirebaseAuth.instance.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(data['storeImage'],),
                  ),
                  Text("Hi ${data['businessName']}")
                ],
              ),
            ),
            body:StreamBuilder<QuerySnapshot>(
              stream: _vendorsStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                double totalOrders = 0.0;
                for(var order in snapshot.data!.docs){
                  totalOrders += order[''];
                }
                return Center(
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade900
                        ),
                      )
                    ],
                  ),
                );
              },
            )




          );
        }

        return Text("loading");
      },
    );
  }
}
