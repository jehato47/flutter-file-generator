import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sgs_app/widgets/home/web_navrail_screen.dart';

import '../../screens/bottom_navbar.dart';
import '../login/firebase_login.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData || FirebaseAuth.instance.currentUser != null) {
          if (kIsWeb && MediaQuery.of(context).size.width > 700) {
            return WebNavRailScreen();
          } else {
            return BottomNavbarScreen();
          }
        } else {
          return FirebaseLoginScreen();
        }
      },
    );
  }
}
