import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> signUpUser(String email, String fullName, String phoneNumber,
      String password) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        //create user in firebase
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "Create account success";

        //save to firestore
        await _firebaseFirestore
            .collection("buyers")
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'buyerId': userCredential.user?.uid,
          'address': ''
        });
      } else {
        res = "Please fill all fields";
      }
    } catch (e) {
      print("Fail $e");
    }
    return res;
  }

  Future<String> loginUser(String email, String pass) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty && pass.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        res = "Login Success";
      }else{
        res = "Please fill all field";
      }
    } catch (e) {
      print(e.toString());
    }return res;
  }

}
