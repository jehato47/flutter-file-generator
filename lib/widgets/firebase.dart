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

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {},
          )
        ],
      ),
      body:
          // Center(
          //     child: SfPdfViewer.network(
          //   "https://firebasestorage.googleapis.com/v0/b/sgs-create.appspot.com/o/W1K1183451N114434%2FW1K1183451N114434.pdf?alt=media&token=89acf770-21b1-4170-86bb-b9a1f442e327",
          //   enableTextSelection: true,
          //   interactionMode: PdfInteractionMode.selection,
          // )),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("files").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                List<QueryDocumentSnapshot> docs =
                    (snapshot.data as QuerySnapshot).docs;
                List<String> suggestions = docs
                    .map((e) {
                      companies[e["exporterCompany"]] = e["exporterAddress"];
                      return e["exporterCompany"].toString();
                    })
                    .toSet()
                    .toList();

                // List<String> addresses = docs.map((e)=>)
                // List<String> suggestions = suggestionsf;
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleAutoCompleteTextField(
                        minLength: 0,
                        suggestionsAmount: 5,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              _controller2.clear();
                            },
                          ),
                        ),
                        key: key,
                        controller: _controller,
                        clearOnSubmit: false,
                        textSubmitted: (data) {
                          setState(() {
                            _controller.text = data;
                            _controller2.text = companies[data] as String;
                          });
                        },
                        suggestions: suggestions,
                      ),
                      TextField(
                        key: key2,
                        controller: _controller2,
                      ),
                    ],
                  ),
                );
              }),
    );
  }
}
