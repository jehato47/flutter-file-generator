import 'dart:typed_data';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../screens/map_screen.dart';

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

  Future<void> showInMap(BuildContext context, String address) async {
    var googleGeocoding =
        GoogleGeocoding("AIzaSyC1VRXx_dWi58eIf-lWpIwtA5ClJYlAoDw");
    var risult = await googleGeocoding.geocoding.get(address, []);

    print(risult!.results![0].geometry!.location!.lng);
    // setState(() {
    var latLng = LatLng(
      risult.results![0].geometry!.location!.lat!,
      risult.results![0].geometry!.location!.lng!,
    );
    // });
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MapScreen(
          latLng: latLng,
        );
      },
    ));
  }

  void formHelper() {}
}
