import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> signUpUser(String email, String fullName, String phoneNumber,
      String password, Uint8List image) async {
    String res = "Some error";
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          image.isNotEmpty &&
          password.isNotEmpty) {
        //create user in firebase
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String profileImageUrl = await uploadProfileImageToStorage(image);
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
          'address': '',
          'profileImage' : profileImageUrl
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
      } else {
        res = "Please fill all field";
      }
    } catch (e) {
      print(e.toString());
    }
    return res;
  }

  uploadProfileImageToStorage(Uint8List image) async {
    Reference reference = _firebaseStorage
        .ref()
        .child("profilePics")
        .child(_firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = reference.putData(image);
    TaskSnapshot snapshot = await uploadTask;
    String dowUrl = await snapshot.ref.getDownloadURL();
    return dowUrl;
  }
}
