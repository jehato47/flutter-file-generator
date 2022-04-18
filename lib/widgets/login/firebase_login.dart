import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class FirebaseLoginScreen extends StatelessWidget {
  const FirebaseLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(
        providerConfigs: [
          EmailProviderConfiguration(),
          // GoogleProviderConfiguration(
          //   clientId:
          //       '73640989291-c0l6vi0v9o2hhvoqjmfrl9k6t1h8pv1e.apps.googleusercontent.com',
          // ),
          // PhoneProviderConfiguration()
        ],
      ),
    );
  }
}
