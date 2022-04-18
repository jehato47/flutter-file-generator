import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import 'pdf/sgs_form.dart';
import 'xlsx/xlsx_form.dart';
import 'file_list_screen.dart';

class BottomNavbarScreen extends StatefulWidget {
  @override
  _BottomNavbarScreenState createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  int index = 0;
  List bodies = [
    FileListScreen(),
    SgsForm(),
    XlsxForm(),
  ];

  String? profileImage = (FirebaseAuth.instance).currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sgs Düzenleyici"),
        actions: [
          auth.currentUser?.photoURL != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(profileImage ?? ""),
                )
              : Container(),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              final isSignedIn = await GoogleSignIn().isSignedIn();
              if (isSignedIn) await GoogleSignIn().signOut();

              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => LoginScreen(),
              // ));
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: index == 1
            ? Colors.red
            : index == 2
                ? Colors.green
                : Colors.blue,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.green,
            ),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              // color: Colors.red,
            ),
            label: "pdf",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment,
              // color: Colors.green,
            ),
            label: "xlsx",
          ),
        ],
      ),
      body: bodies[index],
    );
  }
}
