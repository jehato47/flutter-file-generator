import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgs_app/provider/sgs_provider.dart';
import 'package:sgs_app/widgets/xlsx/save_xlsx_button.dart';
import '../../provider/core_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class XlsxForm extends StatefulWidget {
  @override
  _XlsxFormState createState() => _XlsxFormState();
}

class _XlsxFormState extends State<XlsxForm> {
  bool isLoading = false;
  // final _formKey = GlobalKey<FormState>();

  // Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Sgs>(context, listen: false);

    FirebaseAuth auth = FirebaseAuth.instance;
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: prov.xlsxFormKey,
        child: ListView(
          children: [
            Text(
              "Excel Dosyası Bilgileri",
              style: TextStyle(fontSize: 20),
            ),
            Divider(),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                print(value);
                if (value == "") return "Markayı Girin";

                return null;
              },
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                prov.xlsxFormData["carBrand"] = newValue;
              },
              decoration: InputDecoration(labelText: "Araç Marka"),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == "") return "Modeli Girin";

                return null;
              },
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                prov.xlsxFormData["carModel"] = newValue;
              },
              decoration: InputDecoration(labelText: "Araç Model"),
            ),
            SizedBox(height: 10),
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onSaved: (newValue) {
                prov.xlsxFormData["carYear"] = newValue;
              },
              validator: (value) {
                dynamic v;

                v = int.tryParse((value as String));
                if (v == null) return "Sayı Girin";

                return null;
              },
              decoration: InputDecoration(labelText: "Araç Yıl"),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              // onChanged: (value) {
              //   dynamic v;
              //   try {
              //     v = int.tryParse(value);
              //     print(v);
              //     return
              //   } catch (err) {
              //     print(err);
              //   }
              //   print(v);
              // },
              validator: (value) {
                dynamic v;

                v = int.tryParse((value as String));
                if (v == null) return "Sayı Girin";

                return null;
              },
              onSaved: (newValue) {
                prov.xlsxFormData["old"] = newValue;
              },
              decoration: InputDecoration(labelText: "Yaş"),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == "") return "Ülkeyi Girin";

                return null;
              },
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                prov.xlsxFormData["country"] = newValue;
              },
              decoration: InputDecoration(labelText: "Ülke"),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == "") return "Vin Numarasını Girin";

                return null;
              },
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                prov.xlsxFormData["vinNumber"] = newValue;
              },
              decoration: InputDecoration(labelText: "Vin Numarası"),
            ),
            SizedBox(height: 10),
            SaveXlsxButton(),
          ],
        ),
      ),
    );
  }
}
