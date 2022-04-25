import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_responsive/bottom_navbar.dart';
import 'package:school_responsive/file_list_screen.dart';
import 'package:school_responsive/firebase.dart';
// import 'dashboard_screen.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);
  Future<dynamic> login(BuildContext context, LoginData data) async {
    // return null;
    final result = await Provider.of<Auth>(context, listen: false)
        .signIn(data.name, data.password);
    return result;
  }

  Future<dynamic> signUp(BuildContext context, LoginData data) async {
    // return null;
    final result = await Provider.of<Auth>(context, listen: false)
        .singUp(data.name, data.password);
    return result;
  }

  // Future<String> _authUser(LoginData data) {
  //   print('Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(data.name)) {
  //       return 'Username not exists';
  //     }
  //     if (users[data.name] != data.password) {
  //       return 'Password does not match';
  //     }
  //     return null;
  //   });
  // }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      loginProviders: [
        LoginProvider(
          callback: () async {
            // GoogleSignInAccount signInAccount = await GoogleSignIn().signIn();

            try {
              GoogleSignInAccount account = await GoogleSignIn().signIn();
              if (account != null) {
                GoogleSignInAuthentication inAuthentication =
                    await account.authentication;
                UserCredential credential =
                    await FirebaseAuth.instance.signInWithCredential(
                  GoogleAuthProvider.credential(
                    idToken: inAuthentication.idToken,
                    accessToken: inAuthentication.accessToken,
                  ),
                );
                print(account.email);
                print(credential.user);
                print(account.photoUrl);
              } else {
                return "Giriş Yapmadınız";
              }
              return null;
            } catch (error) {
              print(error);
              return error.toString();
            }
          },
          icon: FontAwesomeIcons.google,
        )
      ],
      theme: LoginTheme(
        textFieldStyle:
            TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
        buttonTheme: LoginButtonTheme(
            // backgroundColor: Colors.red,
            ),
      ),

      messages: LoginMessages(
        usernameHint: "Kullanıcı Adı",
        passwordHint: "Şifre",
        flushbarTitleError: "Hata",
        loginButton: "Giriş Yap",
        signupButton: "Kayıt Ol",
      ),
      title: 'Sgs Düzenleyici',

      // logo: 'assets/images/ecorp-lightblue.png',
      hideForgotPasswordButton: true,
      onLogin: (LoginData data) async {
        final response = await login(context, data);
        return response;
      },
      onSignup: (LoginData data) async {
        final response = await signUp(context, data);
        return response;
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => BottomNavbarScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  Future<ElevatedButton> googleLoginButton() async {
    return ElevatedButton(
      onPressed: () async {
        // GoogleSignInAccount signInAccount = await GoogleSignIn().signIn();

        try {
          GoogleSignInAccount account = await GoogleSignIn(
            scopes: [
              'email',
              'https://www.googleapis.com/auth/contacts.readonly',
            ],
          ).signIn();
          if (account != null) {
            GoogleSignInAuthentication inAuthentication =
                await account.authentication;
            UserCredential credential =
                await FirebaseAuth.instance.signInWithCredential(
              GoogleAuthProvider.credential(
                idToken: inAuthentication.idToken,
                accessToken: inAuthentication.accessToken,
              ),
            );
            print(account.email);
            print(credential.user);
          }
        } catch (error) {
          print(error);
        }
      },
      child: Text("signin"),
    );
  }
}
