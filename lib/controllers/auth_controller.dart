import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
      } else {
        res = "Please fill all fields";
      }
    } catch (e) {
      print("Fail $e");
    }return res;
  }
}
