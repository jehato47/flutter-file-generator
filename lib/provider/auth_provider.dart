import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth extends ChangeNotifier {
  Future<void> singUp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
  }

  Future<void> signIn() async {}
}
