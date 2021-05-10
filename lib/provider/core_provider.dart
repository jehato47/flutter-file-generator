import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:io';

class Core extends ChangeNotifier {
  Future<void> sendForm(_formData) async {
    var dio = dioo.Dio();
    // print("ok");
    dio.options.baseUrl = 'http://localhost:8000';

    // return;

    print(_formData["carModel"]);
    // final bytes = await _formData["invoice"].readAsBytes();
    // return;
    var formData = dioo.FormData.fromMap({
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
      'invoice': await dioo.MultipartFile.fromFile('./text.txt',
          filename: 'upload.txt'),
      'invoice': dioo.MultipartFile.fromBytes(
        _formData["invoice"],
        filename: "q12.jpeg",
      ),
    });
    var response = await dio.post(
      '/sgs/createsgs',
      data: formData,
    );
    print(response);
  }

  Future<void> createXlsx(Map _formData) async {
    var dio = dioo.Dio();
    // print("ok");
    dio.options.baseUrl = 'http://localhost:8000';

    var formData = dioo.FormData.fromMap({
      'carBrand': _formData["carBrand"],
      'carModel': _formData["carModel"],
      'carYear': _formData["carYear"],
      'old': _formData['old'],
      'country': _formData['country'],
      'vinNumber': _formData['vinNumber']
    });

    var response = await dio.post(
      '/sgs/createxlsx',
      data: formData,
    );
    print(response);
  }

  Future<void> getXlsxUrl(String vinN) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    final response = await storage.ref("$vinN/$vinN.xlsx").getDownloadURL();
    print(response);
    // return;
    void _launchURL(_url) async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';

    _launchURL(response);
  }

  Future<void> getPdfUrl(String vinN) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    final response = await storage.ref("$vinN/$vinN.pdf").getDownloadURL();
    print(response);
    // return;
    void _launchURL(_url) async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';

    _launchURL(response);
  }

  Future<void> trySend() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:8000/sgs/createsgs'));
    request.fields.addAll({
      'exporterCompany': 'DAF Finland',
      'exporterAddress': 'Norway \nCenter Avenue',
      'contactPerson': 'Jehat Deniz',
      'email': 'jehato47@hotmail.com',
      'phone': '00905366639292',
      'importerCompany': 'Sheek Company',
      'importerAddress': 'Musul / Iraq',
      'invoiceNoDate': '2022.03.04 / 13223',
      'carBrand': 'DAF',
      'carModel': '3355S',
      'carYear': '2012',
      'old': '9',
      'country': 'Norway',
      'vinNumber': 'WDB9341611L592218'
    });
    request.files.add(await http.MultipartFile.fromPath(
        'invoice', '/C:/Users/LENOVO/Downloads/photo6318662445022948375.jpg'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
