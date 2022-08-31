import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FirebaseScreen extends StatefulWidget {
  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  int index = 0;

  String currentText = "";
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Map<String, String> companies = {
      "Truckland Aps": "Højbjerg Huse 7, 8840 Rødkærsbro, Danimarka",
      "Hoplog Oy": "Keskikankaantie 28, 15860 Hollola, Finlandiya",
    };
    List<String> sugg = companies.keys.toList();
    // List<String> add = companies.values.toList();
    bool isLoading = false;
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              onDestinationSelected: (value) {
                setState(() {
                  index = value;
                });
              },
              selectedIndex: index,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text("123"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.data_array),
                  label: Text("123"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.ballot),
                  label: Text("123"),
                ),
              ],
            ),
            Center(
              child: Text(index.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
