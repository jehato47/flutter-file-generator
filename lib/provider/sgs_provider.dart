import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Sgs extends ChangeNotifier {
  Future<void> sendFormm(dynamic formData, FilePickerResult result) async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';
    var _formData;

    _formData = FormData.fromMap({
      'exporterCompany': formData["exporterCompany"],
      'exporterAddress': formData["exporterAddress"],
      'contactPerson': 'KENDAL DENIZ',
      'email': 'kendalkendalo@hotmail.com',
      'phone': '00905325664883',
      'importerCompany': formData["importerCompany"],
      'importerAddress': formData["importerAddress"],
      'invoiceNoDate': formData["invoiceNoDate"],
      'vinNumber': formData["vinNumber"],
      'invoice': MultipartFile.fromBytes(
        result.files.single.bytes,
        filename: result.files.single.name,
      ),
    });

    // print(_formData.fields);
    try {
      var response = await dio.post(
        '/sgs/createsgs',
        data: _formData,
      );
      print(response);
    } catch (err) {
      print(err);
    }
  }

  Future<void> sendFormMobile(dynamic formData, dynamic bytess) async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';
    var _formData;

    _formData = FormData.fromMap({
      'exporterCompany': formData["exporterCompany"],
      'exporterAddress': formData["exporterAddress"],
      'contactPerson': 'KENDAL DENIZ',
      'email': 'kendalkendalo@hotmail.com',
      'phone': '00905325664883',
      'importerCompany': formData["importerCompany"],
      'importerAddress': formData["importerAddress"],
      'invoiceNoDate': formData["invoiceNoDate"],
      'vinNumber': formData["vinNumber"],
      'invoice': MultipartFile.fromBytes(
        bytess,
        filename: "qwe.jpeg",
      ),
    });

    // print(_formData.fields);
    try {
      var response = await dio.post(
        '/sgs/createsgs',
        data: _formData,
      );
      print(response);
    } catch (err) {
      print(err);
    }
  }
}
