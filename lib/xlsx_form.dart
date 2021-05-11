import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class XlsxForm extends StatefulWidget {
  @override
  _XlsxFormState createState() => _XlsxFormState();
}

class _XlsxFormState extends State<XlsxForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("Excel File Info"),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carBrand"] = newValue;
              },
              decoration: InputDecoration(labelText: "car brand"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carModel"] = newValue;
              },
              decoration: InputDecoration(labelText: "car model"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carYear"] = newValue;
              },
              decoration: InputDecoration(labelText: "car year"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["old"] = newValue;
              },
              decoration: InputDecoration(labelText: "old"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["country"] = newValue;
              },
              decoration: InputDecoration(labelText: "country"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["vinNumber"] = newValue;
              },
              decoration: InputDecoration(labelText: "vin number"),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      _formKey.currentState.save();
                      print(formData);

                      await Provider.of<Core>(context, listen: false)
                          .createXlsx(formData);
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Oluşturuldu indirme başlıyor"),
                          backgroundColor: Colors.green,
                        ),
                      );

                      final url =
                          await Provider.of<Core>(context, listen: false)
                              .getXlsxUrl(formData["vinNumber"]);

                      DocumentSnapshot snapshot = await FirebaseFirestore
                          .instance
                          .collection("files")
                          .doc(formData["vinNumber"])
                          .get();

                      if (snapshot.exists)
                        await FirebaseFirestore.instance
                            .collection("files")
                            .doc(formData["vinNumber"])
                            .update({
                          'xlsx': true,
                          'carBrand': formData["carBrand"],
                          'carModel': formData["carModel"],
                          'carYear': formData["carYear"],
                          'old': formData['old'],
                          'country': formData['country'],
                          'vinNumber': formData['vinNumber'],
                          'url': url,
                          'uid': auth.currentUser.uid,
                        });
                      else {
                        await FirebaseFirestore.instance
                            .collection("files")
                            .doc(formData["vinNumber"])
                            .set({
                          'pdf': false,
                          'xlsx': true,
                          'date': DateTime.now(),
                          'carBrand': formData["carBrand"],
                          'carModel': formData["carModel"],
                          'carYear': formData["carYear"],
                          'old': formData['old'],
                          'country': formData['country'],
                          'vinNumber': formData['vinNumber'],
                          'url': url,
                          'uid': auth.currentUser.uid,
                        });
                      }
                    },
                    child: Text("btn"),
                  )
          ],
        ),
      ),
    );
  }
}
