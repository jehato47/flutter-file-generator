import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends ChangeNotifier {
  Future<dynamic> singUp(String? email, String? password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return null;
    } catch (err) {
      return err.toString();
    }
  }

  Future<void> signIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return null;
    } catch (err) {
      // ! Bak
      throw err.toString();
    }
  }
}
