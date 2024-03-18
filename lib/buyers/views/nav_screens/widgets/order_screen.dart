import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where("buyerId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text("My Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Timestamp miliSecondOrder = data['orderDate'];
              Timestamp miliSecondDeli = data['scheduleDate'];
              int miliDeli = miliSecondDeli.millisecondsSinceEpoch;
              int miliOrder = miliSecondOrder.millisecondsSinceEpoch;
              var dtOrder = DateTime.fromMillisecondsSinceEpoch(miliOrder);
              final f = DateFormat('dd/MM/yyy');

              var dtDeli =
                  f.format(DateTime.fromMillisecondsSinceEpoch(miliDeli));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: data['accepted'] == true
                          ? const Icon(Icons.delivery_dining)
                          : const Icon(Icons.access_time),
                    ),
                    title: data['accepted'] == true
                        ? const Text("Accepted")
                        : const Text("No Accepted"),
                    trailing: Text("Amount ${data['productPrice']}"),
                  ),
                  Text("$dtOrder"),
                  ExpansionTile(
                    title: const Text("Orders Detail"),
                    subtitle: const Text("View Order Detail"),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(data['productImage'][0]),
                        ),
                        title: Text(data['productName']),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Quantity"),
                                const SizedBox(
                                  width: 40,
                                ),
                                Text("${data['quantity']}")
                              ],
                            ),
                            data['accepted'] == true
                                ? Row(
                              children: [
                                const Text("Schedule delivery date"),
                                const SizedBox(
                                  width: 50,
                                ),
                                Text(dtDeli)
                              ],
                            )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
