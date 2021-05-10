import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
import 'dart:io';

class Try extends ChangeNotifier {
  Future<void> sendForm(_formData) async {
    var dio = Dio();
    // print("ok");
    dio.options.baseUrl = 'http://localhost:8000';

    // return;

    print(_formData["carModel"]);
    // final bytes = await _formData["invoice"].readAsBytes();
    // return;
    var formData = FormData.fromMap({
      'exporterCompany': _formData["exporterCompany"],
      'exporterAddress': _formData["exporterAddress"],
      'contactPerson': 'KENDAL DENIZ',
      'email': 'kendalkendalo@hotmail.com',
      'phone': '00905325664883',
      'importerCompany': _formData["importerCompany"],
      'importerAddress': _formData["importerAddress"],
      'invoiceNoDate': _formData["invoiceNoDate"],
      'vinNumber': _formData['vinNumber'],
      // 'invoice': _formData["invoice"],
      'invoice':
          await MultipartFile.fromFile('./text.txt', filename: 'upload.txt'),
      // 'invoice':
      //     MultipartFile.fromBytes(bytes, filename: _formData["invoice"].name),
    });
    var response = await dio.post(
      '/sgs/createsgs',
      data: formData,
    );
    print(response);
  }
}
