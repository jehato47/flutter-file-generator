import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/core_provider.dart';
import '../../provider/sgs_provider.dart';
import 'dart:io';

class SavePdfButton extends StatefulWidget {
  const SavePdfButton({
    Key? key,
  }) : super(key: key);

  @override
  State<SavePdfButton> createState() => _SavePdfButtonState();
}

class _SavePdfButtonState extends State<SavePdfButton> {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Sgs>(context, listen: false);

    GlobalKey<FormState>? _formKey = prov.formKey;
    FilePickerResult? result = prov.result;
    Map formData = prov.formData;
    File? file = prov.file;

    return ElevatedButton(
      onPressed: isLoading
          ? () {}
          : () async {
              FocusScope.of(context).unfocus();
              bool isValid = _formKey.currentState!.validate();
              if (result == null)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Resim Seçin"),
                  ),
                );
              if (!isValid) return;
              _formKey.currentState?.save();

              formData["exporterAddress"] =
                  prov.exporterAddressController.text.trim();
              formData["exporterCompany"] =
                  prov.exporterNameController.text.trim();

              formData["importerAddress"] =
                  prov.importerAddressController.text.trim();
              formData["importerCompany"] =
                  prov.importerNameController.text.trim();

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
                  final bytes = await file!.readAsBytes();
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

              final url = await Provider.of<Core>(context, listen: false)
                  .getPdfUrl(formData["vinNumber"]);

              DocumentSnapshot snapshot = await FirebaseFirestore.instance
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
                  'uid': auth.currentUser?.uid,
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
                  'uid': auth.currentUser?.uid,
                });
              }

              await launch(url);
              return;
            },
      child: isLoading
          ? Center(
              child: SizedBox(
                height: 15.0,
                width: 15.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            )
          : Text("kaydet"),
    );
  }
}
