import 'package:flutter/material.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImporterSgsFields extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final dynamic companies;
  final dynamic key1;
  final dynamic key2;

  const ImporterSgsFields(
    this.controller,
    this.controller2,
    this.companies,
    this.key1,
    this.key2,
  );

  @override
  _ImporterSgsFieldsState createState() => _ImporterSgsFieldsState();
}

class _ImporterSgsFieldsState extends State<ImporterSgsFields> {
  @override
  Widget build(BuildContext context) {
    dynamic _controller = widget.controller;
    dynamic _controller2 = widget.controller2;
    dynamic companies = widget.companies;
    dynamic key = widget.key1;
    dynamic key2 = widget.key2;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("files").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot> docs = snapshot.data.docs;
          List<String> suggestions = docs
              .map((e) {
                companies[e["importerCompany"]] = e["importerAddress"];
                return e["importerCompany"].toString();
              })
              .toSet()
              .toList();

          // List<String> addresses = docs.map((e)=>)
          // List<String> suggestions = suggestionsf;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleAutoCompleteTextField(
                textInputAction: TextInputAction.next,
                minLength: 0,
                suggestionsAmount: 5,
                decoration: InputDecoration(
                  labelText: "Firma İsmi",
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
                    _controller2.text = companies[data];
                  });
                },
                suggestions: suggestions,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: "Firma Adresi"),
                textInputAction: TextInputAction.next,
                key: key2,
                controller: _controller2,
              ),
              SizedBox(height: 20)
            ],
          );
        });
  }
}
