import 'provider/try_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:url_launcher/url_launcher.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

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
                            await Provider.of<Core>(context).trySend();
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Oluşturuldu indirme başlıyor"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            // await Provider.of<Core>(context)
                            //     .getPdfUrl(formData["vinNumber"]);
                          },
                          child: Text("kaydet"),
                        ),
                  TextButton(
                    child: Text("Pick File"),
                    onPressed: () async {
                      // final _picker = ImagePicker();
                      // final pickedFile =
                      //     await _picker.getImage(source: ImageSource.gallery);
                      // final File file = File(pickedFile.path);

                      // var image = Image.network(pickedFile.path);
                      // image = Image.memory(await pickedFile.readAsBytes());

                      // InputElement input = FileUploadInputElement()
                      //   ..accept = "/images";

                      // input.click();
                      // input.onChange.listen((event) async {
                      //   final file = input.files.first;
                      //   final reader = FileReader();
                      //   reader.onLoadEnd.listen((event) async {
                      //     formData["invoice"] = file;
                      //   });
                      // });

                      FilePickerResult result =
                          await FilePicker.platform.pickFiles();

                      // final reader = FileReader();

                      if (result != null) {
                        // File file = File(result.files.single.path);
                        // File file = File.fromRawPath(rawPath)
                        _formKey.currentState.save();
                        // formData["invoice"] = file;
                        var dio = Dio();
                        // print("ok");
                        dio.options.baseUrl = 'http://localhost:8000';
                        var _formData = FormData.fromMap({
                          'exporterCompany': 'formData["exporterCompany"]',
                          'exporterAddress': 'formData["exporterAddress"]',
                          'contactPerson': 'KENDAL DENIZ',
                          'email': 'kendalkendalo@hotmail.com',
                          'phone': '00905325664883',
                          'importerCompany': 'formData["importerCompany"]',
                          'importerAddress': 'formData["importerAddress"]',
                          'invoiceNoDate': 'formData["invoiceNoDate"]',
                          'vinNumber': "formData['vinNumber']",
                          // 'invoice': formData["invoice"],
                          // 'invoice': await MultipartFile.fromFile('./text.txt',
                          //     filename: 'upload.txt'),
                          'invoice': MultipartFile.fromBytes(
                            result.files.single.bytes,
                            filename: "q12.jpeg",
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
                        // print(result.files.single.bytes);
                        // print(122);
                      } else {
                        //   // User canceled the picker
                        // }
                        // final reader = FileReader();
                        // final _picker = ImagePicker();
                        // final pickedFile =
                        //     await _picker.getImage(source: ImageSource.gallery);

                        // reader.readAsDataUrl(pickedFile)
                        // final File file = File(pickedFile.path);

                        // formData["invoice"] = file;
                        // print(file);
                      }
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
