import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class WithDrawalScreen extends StatefulWidget {
  const WithDrawalScreen({super.key});

  @override
  State<WithDrawalScreen> createState() => _WithDrawalScreenState();
}

class _WithDrawalScreenState extends State<WithDrawalScreen> {
  final FirebaseFirestore _store = FirebaseFirestore.instance;
  String amount = '';
  String name = '';
  String mobile = '';
  String bankName = '';
  String bankAccountName = '';
  String bankAccountNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text("WithDrawal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value){
                  amount = value;
                },
                decoration: const InputDecoration(hintText: "Amount"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  name = value;
                },
                decoration: const InputDecoration(hintText: "Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  mobile = value;
                },
                decoration: const InputDecoration(hintText: "Mobile"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  bankName = value;
                },
                decoration: const InputDecoration(hintText: "Bank Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  bankAccountName = value;
                },
                decoration: const InputDecoration(hintText: "Bank Account Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value){
                  bankAccountNumber = value;
                },
                decoration: const InputDecoration(hintText: "Bank Account Number"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: TextButton(
                  onPressed: () async{
                    EasyLoading.show();
                    await _store.collection("withdrawal").doc(const Uuid().v4()).set({
                      "Amount" : amount,
                      "Name" : name,
                      "Mobile" : mobile,
                      "BankName" : bankName,
                      "BankAccountName" : bankAccountName,
                      "BankAccountNumber" : bankAccountNumber,
                    }).whenComplete(() => EasyLoading.dismiss());
                  },
                  child: const Text("Get Cash"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
