import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:school_responsive/models/person.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sgs extends ChangeNotifier {
  Future<void> addContactPerson(Person person) async {
    await FirebaseFirestore.instance
        .collection("contactPersons")
        .doc(person.id)
        .get()
        .then((value) async {
      if (!value.exists) {
        await FirebaseFirestore.instance.collection("contactPersons").add({
          "name": person.name,
          "email": person.email,
          "phoneNumber": person.phoneNumber,
          "logistic": person.logistic,
          "addedDate": DateTime.now(),
        });
      }
    });
  }

  // Future<void> sendFormm(dynamic formData, FilePickerResult result) async {
  //   var dio = Dio();
  //   dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';
  //   var _formData;

  //   _formData = FormData.fromMap({
  //     'exporterCompany': formData["exporterCompany"],
  //     'exporterAddress': formData["exporterAddress"],
  //     'contactPerson': 'Israfil Caglar Solgun',
  //     'email': 'caglars@hotmail.de',
  //     'phone': '00905366896550',
  //     'importerCompany': formData["importerCompany"],
  //     'importerAddress': formData["importerAddress"],
  //     'invoiceNoDate': formData["invoiceNoDate"],
  //     'vinNumber': formData["vinNumber"],
  //     'type': "Kendal Deniz",
  //     'invoice': MultipartFile.fromBytes(
  //       result.files.single.bytes,
  //       filename: result.files.single.name,
  //     ),
  //   });

  //   // print(_formData.fields);
  //   try {
  //     var response = await dio.post(
  //       '/sgs/createsgs',
  //       data: _formData,
  //     );
  //     print(response);
  //   } catch (err) {
  //     print(err);
  //   }
  // }

  // Future<void> sendFormMobile(dynamic formData, dynamic bytess) async {
  //   var dio = Dio();
  //   dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';
  //   var _formData;

  //   _formData = FormData.fromMap({
  //     'exporterCompany': formData["exporterCompany"],
  //     'exporterAddress': formData["exporterAddress"],
  //     'contactPerson': 'Israfil Caglar Solgun',
  //     'email': 'caglars@hotmail.de',
  //     'phone': '00905366896550',
  //     'importerCompany': formData["importerCompany"],
  //     'importerAddress': formData["importerAddress"],
  //     'invoiceNoDate': formData["invoiceNoDate"],
  //     'vinNumber': formData["vinNumber"],
  //     'type': formData["type"],
  //     'invoice': MultipartFile.fromBytes(
  //       bytess,
  //       filename: "qwe.jpeg",
  //     ),
  //   });

  //   // print(_formData.fields);
  //   try {
  //     var response = await dio.post(
  //       '/sgs/createsgs',
  //       data: _formData,
  //     );
  //     print(response);
  //   } catch (err) {
  //     print(err);
  //   }
  // }
}
