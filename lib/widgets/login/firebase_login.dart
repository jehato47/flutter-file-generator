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
          GoogleProviderConfiguration(
            clientId:
                "735404252029-8gne6orh22tg26nk0l461urga4f9krtg.apps.googleusercontent.com",
          )
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
