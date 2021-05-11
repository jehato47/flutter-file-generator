import 'package:school_responsive/provider/sgs_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  File file;
  FilePickerResult result;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Map formData = {};

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text("Exporter"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "company name"),
                    onSaved: (newValue) {
                      formData["exporterCompany"] = newValue;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["exporterAddress"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company address"),
                  ),
                  SizedBox(height: 20),
                  Text("Importer"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["importerCompany"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company name"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["importerAddress"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company address"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["invoiceNoDate"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "invoiceNoDate"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["vinNumber"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "vin number"),
                  ),
                  SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState.save();
                            setState(() {
                              isLoading = true;
                            });
                            if (result != null) {
                              if (kIsWeb) {
                                print(12);
                                await Provider.of<Sgs>(context, listen: false)
                                    .sendFormm(formData, result);
                              } else {
                                print(13);
                                final bytes = await file.readAsBytes();
                                print(bytes.length);
                                // return;
                                await Provider.of<Sgs>(context, listen: false)
                                    .sendFormMobile(formData, bytes);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Oluşturuldu indirme başlıyor"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {}

                            setState(() {
                              isLoading = false;
                            });

                            final url =
                                await Provider.of<Core>(context, listen: false)
                                    .getPdfUrl(formData["vinNumber"]);

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
                                'pdf': true,
                                'date': DateTime.now(),
                                'exporterCompany': formData["exporterCompany"],
                                'exporterAddress': formData["exporterAddress"],
                                'contactPerson': 'KENDAL DENIZ',
                                'email': 'kendalkendalo@hotmail.com',
                                'phone': '00905325664883',
                                'importerCompany': formData["importerCompany"],
                                'importerAddress': formData["importerAddress"],
                                'invoiceNoDate': formData["invoiceNoDate"],
                                'vinNumber': formData["vinNumber"],
                                'pdfUrl': url,
                                'uid': auth.currentUser.uid,
                              });
                            else {
                              await FirebaseFirestore.instance
                                  .collection("files")
                                  .doc(formData["vinNumber"])
                                  .set({
                                'pdf': true,
                                'xlsx': false,
                                'date': DateTime.now(),
                                'exporterCompany': formData["exporterCompany"],
                                'exporterAddress': formData["exporterAddress"],
                                'contactPerson': 'KENDAL DENIZ',
                                'email': 'kendalkendalo@hotmail.com',
                                'phone': '00905325664883',
                                'importerCompany': formData["importerCompany"],
                                'importerAddress': formData["importerAddress"],
                                'invoiceNoDate': formData["invoiceNoDate"],
                                'vinNumber': formData["vinNumber"],
                                'pdfUrl': url,
                                'uid': auth.currentUser.uid,
                              });
                            }
                          },
                          child: Text("kaydet"),
                        ),
                  TextButton(
                    child: Text("Pick File"),
                    onPressed: () async {
                      result = await FilePicker.platform.pickFiles();

                      if (!kIsWeb && result != null) {
                        file = File(result.files.single.path);
                      } else {
                        // User canceled the picker
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
