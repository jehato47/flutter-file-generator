import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../file_list_screen.dart';
import '../pdf/sgs_form.dart';
import '../xlsx/xlsx_form.dart';

class WebNavRailScreen extends StatefulWidget {
  const WebNavRailScreen({Key? key}) : super(key: key);

  @override
  State<WebNavRailScreen> createState() => _WebNavRailScreenState();
}

class _WebNavRailScreenState extends State<WebNavRailScreen> {
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
        centerTitle: true,
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
      body: Row(
        children: [
          Spacer(),
          // SizedBox(width: 150),
          NavigationRail(
            onDestinationSelected: (value) {
              setState(() {
                index = value;
              });
            },
            useIndicator: true,
            // indicatorColor: Colors.cyan[50],

            destinations: [
              NavigationRailDestination(
                icon: Icon(
                  Icons.home,
                  // color: Colors.green,
                ),
                selectedIcon: Icon(
                  Icons.home,
                  color: Colors.blue,
                  // color: Colors.green,
                ),
                label: Text("Ana Sayfa"),
              ),
              NavigationRailDestination(
                icon: FaIcon(
                  FontAwesomeIcons.filePdf,
                  // color: Colors.green,
                ),
                // icon: Icon(
                //   Icons.assignment,
                //   // color: Colors.red,
                // ),
                selectedIcon: FaIcon(
                  FontAwesomeIcons.filePdf,
                  color: Colors.red,
                  // color: Colors.green,
                ),
                label: Text(
                  "pdf",
                  style: TextStyle(color: Colors.green),
                ),
              ),
              NavigationRailDestination(
                icon: FaIcon(
                  FontAwesomeIcons.fileExcel,
                  // color: Colors.green,
                ),
                selectedIcon: FaIcon(
                  FontAwesomeIcons.fileExcel,
                  color: Colors.green,
                  // color: Colors.green,
                ),
                label: Text("xlsx"),
              ),
            ],
            selectedIndex: index,
          ),
          VerticalDivider(thickness: 1),
          Expanded(
            child: bodies[index],
            flex: 4,
          ),
          // Expanded(
          //   child: Container(),
          //   flex: 1,
          // ),
          Spacer(),
        ],
      ),
    );
  }
}
