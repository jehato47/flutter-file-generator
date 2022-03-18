import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class SgsProviderWeb extends ChangeNotifier {
  Future<void> sendFormm(dynamic formData, FilePickerResult result) async {
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
      'type': "Kendal Deniz",
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
}
