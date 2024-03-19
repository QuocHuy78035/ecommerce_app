import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomerce_app/vendors/views/screens/store_screens/detail_store_screen.dart';
import 'package:flutter/material.dart';

class VendorStoreScreen extends StatefulWidget {
  const VendorStoreScreen({super.key});

  @override
  State<VendorStoreScreen> createState() => _VendorStoreScreenState();
}

class _VendorStoreScreenState extends State<VendorStoreScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _storesStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _storesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(children: [
          SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  final storeData = snapshot.data?.docs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailStoreScreen(
                            storeData: storeData,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(storeData?['businessName']),
                      subtitle: Text(storeData?['countryValue']),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(storeData?['storeImage']),
                      ),
                    ),
                  );
                }),
          )
        ]);
      },
    );
  }
}
