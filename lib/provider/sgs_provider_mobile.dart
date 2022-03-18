import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SgsProviderMobile extends ChangeNotifier {
  Future<void> sendFormMobile(dynamic formData, dynamic bytess) async {
    var dio = Dio();
    dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';
    var _formData;

    _formData = FormData.fromMap({
      'exporterCompany': formData["exporterCompany"],
      'exporterAddress': formData["exporterAddress"],
      'contactPerson': 'Israfil Caglar Solgun',
      'email': 'caglars@hotmail.de',
      'phone': '00905366896550',
      'importerCompany': formData["importerCompany"],
      'importerAddress': formData["importerAddress"],
      'invoiceNoDate': formData["invoiceNoDate"],
      'vinNumber': formData["vinNumber"],
      'type': formData["type"],
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
