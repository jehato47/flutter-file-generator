import 'package:school_responsive/exporter_sgs_fields.dart';
import 'package:school_responsive/importer_sgs_fields.dart';
import 'package:school_responsive/pdf_screen.dart';
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
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  String currentText = "";
  TextEditingController exporterNameController = new TextEditingController();
  TextEditingController exporterAddressController = new TextEditingController();
  TextEditingController importerNameController = new TextEditingController();
  TextEditingController importerAddressController = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key4 = new GlobalKey();

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
    Map<String, String> companies = {
      "Truckland Aps": "Højbjerg Huse 7, 8840 Rødkærsbro, Danimarka",
      "Hoplog Oy": "Keskikankaantie 28, 15860 Hollola, Finlandiya",
    };
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
                  Text(
                    "İhracatçı",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(),
                  // SizedBox(height: 10),
                  ExporterSgsFields(
                    exporterNameController,
                    exporterAddressController,
                    companies,
                    key,
                    key2,
                  ),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == "") return "Firma Ismini Girin";

                  //     return null;
                  //   },
                  //   textInputAction: TextInputAction.next,
                  //   decoration: InputDecoration(labelText: "Firma İsmi"),
                  //   onSaved: (newValue) {
                  //     formData["exporterCompany"] = newValue;
                  //   },
                  // ),
                  // SizedBox(height: 10),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == "") return "Adresi Girin";

                  //     return null;
                  //   },
                  //   textInputAction: TextInputAction.next,
                  //   onSaved: (newValue) {
                  //     formData["exporterAddress"] = newValue;
                  //   },
                  //   decoration: InputDecoration(labelText: "Firma Adresi"),
                  // ),
                  // SizedBox(height: 20),
                  Text(
                    "İthalatçı",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(),
                  ImporterSgsFields(
                    importerNameController,
                    importerAddressController,
                    companies,
                    key3,
                    key4,
                  ),
                  // SizedBox(height: 10),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == "") return "Firma İsmini Girin";

                  //     return null;
                  //   },
                  //   textInputAction: TextInputAction.next,
                  //   onSaved: (newValue) {
                  //     formData["importerCompany"] = newValue;
                  //   },
                  //   decoration: InputDecoration(labelText: "Firma İsmi"),
                  // ),
                  // SizedBox(height: 10),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == "") return "Adresi Girin";

                  //     return null;
                  //   },
                  //   textInputAction: TextInputAction.next,
                  //   onSaved: (newValue) {
                  //     formData["importerAddress"] = newValue;
                  //   },
                  //   decoration: InputDecoration(labelText: "Firma Adresi"),
                  // ),
                  // Text(
                  //   "Fatura",
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  // Divider(),
                  // SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == "") return "Fatura No ve Tarihi Girin";

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["invoiceNoDate"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "Fatura No / Tarih"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      if (value == "") return "Vin Numarasını Girin";

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["vinNumber"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "Vin Numarası"),
                  ),
                  TextButton(
                    child: Text(file != null
                        ? file.path.split("/").last
                        : "Faturayı Yükle"),
                    onPressed: () async {
                      result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      if (!kIsWeb && result != null) {
                        setState(() {
                          file = File(result.files.single.path);
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  // SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            bool isValid = _formKey.currentState.validate();
                            if (result == null)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Resim Seçin"),
                                ),
                              );
                            if (!isValid) return;
                            _formKey.currentState.save();

                            formData["exporterAddress"] =
                                exporterNameController.text.trim();
                            formData["exporterCompany"] =
                                exporterAddressController.text.trim();

                            formData["importerAddress"] =
                                importerNameController.text.trim();
                            formData["importerCompany"] =
                                importerAddressController.text.trim();

                            // return;
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
                                  content: Text("Oluşturuldu"),
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

                            await launch(url);
                            return;
                          },
                          child: Text("kaydet"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
