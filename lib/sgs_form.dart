import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_responsive/pick_contact_person.dart';
import 'package:school_responsive/provider/sgs_provider_mobile.dart';
import 'package:school_responsive/provider/sgs_provider_web.dart';
import 'package:url_launcher/url_launcher.dart';

import 'exporter_sgs_fields.dart';
import 'importer_sgs_fields.dart';
import 'provider/core_provider.dart';
import 'provider/form_provider.dart';
import 'provider/sgs_provider.dart';

class SgsForm extends StatefulWidget {
  @override
  _SgsFormState createState() => _SgsFormState();
}

class _SgsFormState extends State<SgsForm> {
  bool isLoading = false;
  File file;
  @override
  Widget build(BuildContext context) {
    FormProvider formProvider =
        Provider.of<FormProvider>(context, listen: false);

    FilePickerResult result = formProvider.result;
    Map formData = formProvider.formData;

    Map<String, String> companies = {
      "Truckland Aps": "Højbjerg Huse 7, 8840 Rødkærsbro, Danimarka",
      "Hoplog Oy": "Keskikankaantie 28, 15860 Hollola, Finlandiya",
    };
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: formProvider.formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "İhracatçı",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(),
                  // SizedBox(height: 10),
                  ExporterSgsFields(
                    formProvider.exporterNameController,
                    formProvider.exporterAddressController,
                    companies,
                    formProvider.key,
                    formProvider.key2,
                  ),

                  Text(
                    "İthalatçı",
                    style: TextStyle(fontSize: 20),
                  ),
                  Divider(),
                  ImporterSgsFields(
                    formProvider.importerNameController,
                    formProvider.importerAddressController,
                    companies,
                    formProvider.key3,
                    formProvider.key4,
                  ),

                  TextFormField(
                    controller: formProvider.invoiceNoController,
                    validator: (value) {
                      if (value == "") return "Fatura No ve Tarihi Girin";

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Fatura No / Tarih"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: formProvider.vinNoController,
                    validator: (value) {
                      if (value == "") return "Vin Numarasını Girin";

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: "Vin Numarası"),
                  ),
                  Consumer<FormProvider>(builder: (context, value, child) {
                    result = value.result;
                    file = value.file;
                    return TextButton(
                      child: Text(
                        file != null
                            ? file.path.split("/").last
                            : "Faturayı Yükle",
                      ),
                      onPressed: () async {
                        await formProvider.pickFile();
                      },
                    );
                  }),
                  // SizedBox(height: 20),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            print("done");

                            formProvider.createForm();
                            if (result == null && file == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Faturayı Seçin"),
                                ),
                              );
                              return;
                            }
                            await showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: PickContactPerson(),
                                ),
                              ),
                            );
                            if (formProvider.pickedPerson == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Aracı Kişiyi Seçin",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });
                            if (result != null) {
                              if (kIsWeb) {
                                await Provider.of<SgsProviderWeb>(context,
                                        listen: false)
                                    .sendFormm(formData, result);
                              } else {
                                final bytes =
                                    await formProvider.file.readAsBytes();

                                await Provider.of<SgsProviderMobile>(context,
                                        listen: false)
                                    .sendFormMobile(formData, bytes);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Oluşturuldu"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {}

                            setState(() {
                              isLoading = false;
                            });

                            formProvider.url =
                                await Provider.of<Core>(context, listen: false)
                                    .getPdfUrl(formData["vinNumber"]);

                            await formProvider.createDocument();

                            await launch(formProvider.url);
                            return;
                          },
                          child: Text("kaydet"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
