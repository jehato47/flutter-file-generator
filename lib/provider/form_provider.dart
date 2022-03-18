import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:school_responsive/models/person.dart';

class FormProvider extends ChangeNotifier {
  Person _pickedPerson;
  Person get pickedPerson => _pickedPerson;

  void changePickedPerson(Person person) {
    _formData["type"] = person.name;
    _pickedPerson = person;
    // notifyListeners();
  }

  Map _formData = {};
  String url;
  File file;
  FilePickerResult result;
  final formKey = GlobalKey<FormState>();
  TextEditingController exporterNameController = new TextEditingController();
  TextEditingController exporterAddressController = new TextEditingController();
  TextEditingController importerNameController = new TextEditingController();
  TextEditingController importerAddressController = new TextEditingController();
  TextEditingController invoiceNoController = new TextEditingController();
  TextEditingController vinNoController = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key4 = new GlobalKey();

  Map get formData => _formData;

  void createForm() {
    bool isValid = formKey.currentState.validate();
    if (!isValid) return;

    formKey.currentState.save();

    _formData["exporterAddress"] = exporterNameController.text.trim();
    _formData["exporterCompany"] = exporterAddressController.text.trim();

    _formData["importerAddress"] = importerNameController.text.trim();
    _formData["importerCompany"] = importerAddressController.text.trim();

    _formData["invoiceNoDate"] = invoiceNoController.text.trim();
    _formData["vinNumber"] = vinNoController.text.trim();

    print(_formData);
  }

  Future<void> pickFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (!kIsWeb && result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
    notifyListeners();

    print(file);
  }

  Future<void> createDocument() async {
    final auth = FirebaseAuth.instance;
    await FirebaseFirestore.instance
        .collection("files")
        .doc(formData["vinNumber"])
        .get()
        .then((value) async {
      if (value.exists) {
        await FirebaseFirestore.instance
            .collection("files")
            .doc(formData["vinNumber"])
            .update({
          'pdf': true,
          'date': DateTime.now(),
          'exporterCompany': formData["exporterCompany"],
          'exporterAddress': formData["exporterAddress"],
          'contactPerson': pickedPerson?.name,
          'email': pickedPerson?.email,
          'phone': pickedPerson?.phoneNumber,
          'importerCompany': formData["importerCompany"],
          'importerAddress': formData["importerAddress"],
          'invoiceNoDate': formData["invoiceNoDate"],
          'vinNumber': formData["vinNumber"],
          'pdfUrl': url,
          'uid': auth.currentUser.uid,
        });
      } else {
        await FirebaseFirestore.instance
            .collection("files")
            .doc(formData["vinNumber"])
            .set({
          'pdf': true,
          'xlsx': false,
          'date': DateTime.now(),
          'exporterCompany': formData["exporterCompany"],
          'exporterAddress': formData["exporterAddress"],
          'contactPerson': pickedPerson?.name,
          'email': pickedPerson?.email,
          'phone': pickedPerson?.phoneNumber,
          'importerCompany': formData["importerCompany"],
          'importerAddress': formData["importerAddress"],
          'invoiceNoDate': formData["invoiceNoDate"],
          'vinNumber': formData["vinNumber"],
          'pdfUrl': url,
          'uid': auth.currentUser.uid,
        });
      }
      // clearFields();
      return value;
    });
  }

  void clearFields() {
    // formKey.currentState.reset();
    _formData = {};
    exporterNameController.clear();
    exporterAddressController.clear();
    importerNameController.clear();
    importerAddressController.clear();
    invoiceNoController.clear();
    vinNoController.clear();
    file = null;
    result = null;
    notifyListeners();
  }
}
