import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sgs_app/screens/profile_screen.dart';
import 'login_screen.dart';
import '../widgets/pdf/sgs_form.dart';
import '../widgets/xlsx/xlsx_form.dart';
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
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      ProfileScreen.url,
                    );
                  },
                  child: Hero(
                    tag: profileImage!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(profileImage ?? ""),
                    ),
                  ),
                )
              : IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.solidUser,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      ProfileScreen.url,
                    );
                  },
                ),
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: () async {
          //     await FirebaseAuth.instance.signOut();
          //     final isSignedIn = await GoogleSignIn().isSignedIn();
          //     if (isSignedIn) await GoogleSignIn().signOut();

          //     // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     //   builder: (context) => LoginScreen(),
          //     // ));
          // },
          // )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: index == 1
        //     ? Colors.red
        //     : index == 2
        //         ? Colors.green
        //         : Colors.blue,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.home,
              color: index == 0 ? Colors.blue : Colors.grey,
            ),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.filePdf,
              color: index == 1 ? Colors.red : Colors.grey,
            ),
            label: "pdf",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.fileExcel,
              color: index == 2 ? Colors.green : Colors.grey,
            ),
            label: "xlsx",
          ),
        ],
      ),
      body: bodies[index],
    );
  }
}
