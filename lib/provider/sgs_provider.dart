import 'dart:typed_data';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Sgs extends ChangeNotifier {
  // Pdf ***************************
  TextEditingController exporterNameController = new TextEditingController();
  TextEditingController exporterAddressController = new TextEditingController();
  TextEditingController importerNameController = new TextEditingController();
  TextEditingController importerAddressController = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key3 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key4 = new GlobalKey();
  Map formData = {};
  File? file;
  FilePickerResult? result;
  final formKey = GlobalKey<FormState>();

  // Xlsx ***************************
  final xlsxFormKey = GlobalKey<FormState>();
  Map<String, dynamic> xlsxFormData = {};

  Future<void> sendFormm(dynamic formData, FilePickerResult? result) async {
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
      'type': '',
      'invoice': MultipartFile.fromBytes(
        (result?.files.single.bytes as Uint8List),
        filename: result?.files.single.name,
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
      'contactPerson': 'Israfil Caglar Solgun',
      'email': 'caglars@hotmail.de',
      'phone': '00905366896550',
      'importerCompany': formData["importerCompany"],
      'importerAddress': formData["importerAddress"],
      'invoiceNoDate': formData["invoiceNoDate"],
      'vinNumber': formData["vinNumber"],
      'type': '',
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

  void formHelper() {}
}
