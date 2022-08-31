import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';

class ExporterSgsFields extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController controller2;
  final dynamic companies;
  final dynamic key1;
  final dynamic key2;

  const ExporterSgsFields(
    this.controller,
    this.controller2,
    this.companies,
    this.key1,
    this.key2,
  );

  @override
  _ExporterSgsFieldsState createState() => _ExporterSgsFieldsState();
}

class _ExporterSgsFieldsState extends State<ExporterSgsFields> {
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
          List<QueryDocumentSnapshot> docs =
              (snapshot.data as QuerySnapshot).docs;
          docs = docs.where((element) => element["pdf"] == true).toList();

          List<String> suggestions = docs
              .map((e) {
                companies[e["exporterCompany"]] = e["exporterAddress"];
                return e["exporterCompany"].toString();
              })
              .toSet()
              .toList();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   key: key,
              //   controller: _controller,
              //   textInputAction: TextInputAction.next,
              //   decoration: InputDecoration(
              //     labelText: "Firma İsmi",
              //     suffixIcon: IconButton(
              //       icon: Icon(Icons.clear),
              //       onPressed: () {
              //         _controller.clear();
              //         _controller2.clear();
              //       },
              //     ),
              //   ),
              //   onSubmitted: (String? data) {
              //     setState(() {
              //       _controller.text = data;
              //       _controller2.text = companies[data];
              //     });
              //   },
              // ),
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
