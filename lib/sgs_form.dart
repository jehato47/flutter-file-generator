import 'provider/try_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  FilePickerResult result;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<void> sendFormm(FilePickerResult result) async {
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
    print(_formData.fields);
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

  Map formData = {
    // "companyName":
  };
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text("Exporter"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "company name"),
                    onSaved: (newValue) {
                      formData["exporterCompany"] = newValue;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["exporterAddress"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company address"),
                  ),
                  SizedBox(height: 20),
                  Text("Importer"),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["importerCompany"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company name"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["importerAddress"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "company address"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["invoiceNoDate"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "invoiceNoDate"),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    onSaved: (newValue) {
                      formData["vinNumber"] = newValue;
                    },
                    decoration: InputDecoration(labelText: "vin number"),
                  ),
                  SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            _formKey.currentState.save();
                            setState(() {
                              isLoading = true;
                            });
                            if (result != null) {
                              await sendFormm(result);
                            } else {}
                            setState(() {
                              isLoading = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Oluşturuldu indirme başlıyor"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            await Provider.of<Core>(context)
                                .getPdfUrl(formData["vinNumber"]);
                          },
                          child: Text("kaydet"),
                        ),
                  TextButton(
                    child: Text("Pick File"),
                    onPressed: () async {
                      result = await FilePicker.platform
                          .pickFiles(allowedExtensions: ['jpg', 'png', 'jpeg']);

                      _formKey.currentState.save();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
