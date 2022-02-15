import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as dioo;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';

class Core extends ChangeNotifier {
  Future<void> createXlsx(Map _formData) async {
    var dio = dioo.Dio();
    // print("ok");
    dio.options.baseUrl = 'https://jehat22.pythonanywhere.com/';

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

  Future<String> getXlsxUrl(String vinN) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    final response = await storage.ref("$vinN/$vinN.xlsx").getDownloadURL();
    print(response);
    // return;
    void _launchURL(_url) async => await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';

    _launchURL(response);

    return response;
  }

  Future<String> getPdfUrl(String vinN) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;

    final response = await storage.ref("$vinN/$vinN.pdf").getDownloadURL();
    // print(response);
    // // return;
    // void _launchURL(_url) async => await canLaunch(_url)
    //     ? await launch(_url)
    //     : throw 'Could not launch $_url';

    // _launchURL(response);
    return response;
  }
}
