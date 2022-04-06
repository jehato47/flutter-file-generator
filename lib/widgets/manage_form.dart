import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/core_provider.dart';
import 'xlsx_form.dart';
import '../helpers/truncate_string.dart';
import 'mail_dialog.dart';

class ManageForm extends StatefulWidget {
  static const url = "manage-form";
  const ManageForm({Key? key}) : super(key: key);

  @override
  _ManageFormState createState() => _ManageFormState();
}

class _ManageFormState extends State<ManageForm> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  bool xlsxIsLoading = false;
  bool pdfIsLoading = false;

  Map formData = {};
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final xlsxProv = Provider.of<Core>(context, listen: false);

    var args = ModalRoute.of(context)?.settings.arguments as dynamic;
    bool haveXlsx = args["xlsx"];
    bool havePdf = args["pdf"];
    print(haveXlsx);
    print(havePdf);
    // bool pdfon = havePdf;
    // bool xlsxon = haveXlsx;
    // print(args.data());
    // print(args.length);
    Form xlsxForm = Form(
      child: Text(""),
    );
    Form pdfForm = Form(
      child: Text(""),
    );

    List xlsx = [];
    List pdf = [];
    if (havePdf) {
      pdf = [
        Text(
          "Pdf Info",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Divider(),
        updateField(args, "Aracı Kişi", "contactPerson"),
        SizedBox(height: 10),
        updateField(args, "İhracatçı Adres", "exporterAddress"),
        SizedBox(height: 10),
        updateField(args, "İhracatçı Firma", "exporterCompany"),
        SizedBox(height: 10),
        updateField(args, "İthalatçı Adres", "importerAddress"),
        SizedBox(height: 10),
        updateField(args, "İthalatçı Firma", "importerCompany"),
        SizedBox(height: 10),
        updateField(args, "Fatura No/Tarih", "invoiceNoDate"),
        SizedBox(height: 10),
        updateField(args, "Telefon", "phone"),
        SizedBox(height: 10),
        updateField(args, "Vin Numarası", "vinNumber"),
        SizedBox(height: 10),
        // ElevatedButton(onPressed: () {}, child: Text(args[])),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                _formKey.currentState?.save();
                print(formData);
              },
              child: Text("Sgs Güncelle")),
        )
      ];

      pdfForm = Form(
        key: _formKey,
        child: Column(
          children: [...pdf],
        ),
      );
    }

    if (haveXlsx) {
      xlsx = [
        SizedBox(height: 20),
        Text(
          "Xlsx Info",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        updateField(args, "Araç Marka", "carBrand"),
        SizedBox(height: 10),
        updateField(args, "Araç Model", "carModel"),
        SizedBox(height: 10),
        updateField(args, "Araç Yıl", "carYear"),
        SizedBox(height: 10),
        updateField(args, "Yaş", "old"),
        SizedBox(height: 10),
        updateField(args, "Ülke", "country"),
        SizedBox(height: 10),
        // updateField(args, "Araç Marka", "date"),

        SizedBox(height: 10),
        updateField(args, "Vin Numarası", "vinNumber"),
        SizedBox(height: 10),
        SizedBox(
          child: xlsxIsLoading
              ? Container()
              : ElevatedButton(
                  onPressed: () async {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    _formKey2.currentState?.save();

                    print(formData["vinNumber"]);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Güncelleniyor"),
                        backgroundColor: Colors.amber,
                      ),
                    );
                    setState(() {
                      xlsxIsLoading = true;
                    });
                    await xlsxProv.createXlsx(formData);
                    final url = await Provider.of<Core>(context, listen: false)
                        .getXlsxUrl(formData["vinNumber"]);

                    DocumentSnapshot snapshot = await FirebaseFirestore.instance
                        .collection("files")
                        .doc(formData["vinNumber"])
                        .get();

                    if (snapshot.exists)
                      await FirebaseFirestore.instance
                          .collection("files")
                          .doc(formData["vinNumber"])
                          .update({
                        'xlsx': true,
                        'carBrand': formData["carBrand"],
                        'carModel': formData["carModel"],
                        'carYear': formData["carYear"],
                        'old': formData['old'],
                        'country': formData['country'],
                        'vinNumber': formData['vinNumber'],
                        'url': url,
                        'uid': auth.currentUser?.uid,
                      });
                    else {
                      await FirebaseFirestore.instance
                          .collection("files")
                          .doc(formData["vinNumber"])
                          .set({
                        'pdf': false,
                        'xlsx': true,
                        'date': DateTime.now(),
                        'carBrand': formData["carBrand"],
                        'carModel': formData["carModel"],
                        'carYear': formData["carYear"],
                        'old': formData['old'],
                        'country': formData['country'],
                        'vinNumber': formData['vinNumber'],
                        'url': url,
                        'uid': auth.currentUser?.uid,
                      });
                    }
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Güncellendi"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {
                      xlsxIsLoading = false;
                    });
                  },
                  child: Text("Ruhsat Güncelle"),
                ),
          width: double.infinity,
        )
      ];

      xlsxForm = Form(
        key: _formKey2,
        child: Column(
          children: [...xlsx],
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => MailDialog(args),
                );
              },
              icon: Icon(Icons.mail),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          // child: Text("qwe"),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    if (havePdf) pdfForm,
                    if (haveXlsx) xlsxForm,
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Row updateField(args, String fieldName, String variableName) {
    return Row(
      children: [
        SizedBox(
          child: Text(fieldName),
          width: 150,
        ),
        // SizedBox(width: 100),
        Expanded(
          child: TextFormField(
            onSaved: (newValue) {
              formData[variableName] = newValue?.trim();
            },
            initialValue: args[variableName],
          ),
        ),
      ],
    );
  }
}
