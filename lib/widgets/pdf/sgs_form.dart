// import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'dart:io';

import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sgs_app/widgets/pdf/save_pdf_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/core_provider.dart';
import '../../provider/sgs_provider.dart';
import 'exporter_sgs_fields.dart';
import 'importer_sgs_fields.dart';

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  String currentText = "";
  // TextEditingController exporterNameController = new TextEditingController();
  // TextEditingController exporterAddressController = new TextEditingController();
  // TextEditingController importerNameController = new TextEditingController();
  // TextEditingController importerAddressController = new TextEditingController();
  // GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  // GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  // GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  // GlobalKey<AutoCompleteTextFieldState<String>> key4 = new GlobalKey();
  // GlobalKey key = new GlobalKey();
  // GlobalKey key2 = new GlobalKey();
  // GlobalKey key3 = new GlobalKey();
  // GlobalKey key4 = new GlobalKey();

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  // Map formData = {};

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Sgs>(context, listen: false);
    TextEditingController exporterNameController = prov.exporterNameController;
    TextEditingController exporterAddressController =
        prov.exporterAddressController;
    TextEditingController importerNameController = prov.importerNameController;
    TextEditingController importerAddressController =
        prov.importerAddressController;
    GlobalKey<AutoCompleteTextFieldState<String>> key = prov.key;
    GlobalKey<AutoCompleteTextFieldState<String>> key2 = prov.key2;
    GlobalKey<AutoCompleteTextFieldState<String>> key3 = prov.key3;
    GlobalKey<AutoCompleteTextFieldState<String>> key4 = prov.key4;
    // File? file = prov.file;
    // FilePickerResult? result = prov.result;
    // final _formKey = prov.formKey;

    Map formData = prov.formData;

    Map<String, String> companies = {
      "Truckland Aps": "Højbjerg Huse 7, 8840 Rødkærsbro, Danimarka",
      "Hoplog Oy": "Keskikankaantie 28, 15860 Hollola, Finlandiya",
    };

    FirebaseAuth auth = FirebaseAuth.instance;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: prov.formKey,
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
                  SizedBox(height: 10),
                  TextButton(
                    child: kIsWeb
                        ? Text(
                            prov.result?.files.single.name ?? "Faturayı Yükle")
                        : Text(prov.file != null
                            ? prov.file!.path.split("/").last
                            : "Faturayı Yükle"),
                    onPressed: () async {
                      prov.result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                      );

                      setState(() {});

                      if (!kIsWeb && prov.result != null) {
                        setState(() {
                          prov.file =
                              File((prov.result!.files.single.path as String));
                        });
                      } else {
                        // User canceled the picker
                      }
                    },
                  ),
                  if (kIsWeb) SizedBox(height: 10),

                  SavePdfButton()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
