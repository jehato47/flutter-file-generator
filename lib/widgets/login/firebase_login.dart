import 'package:flutter/foundation.dart';
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
          // if (kIsWeb)

          GoogleProviderConfiguration(
            clientId:
                '735404252029-h0p1hja97mb7gndh4egdr1octue33k8c.apps.googleusercontent.com',
          ),
        ],
      ),
    );
  }
}
