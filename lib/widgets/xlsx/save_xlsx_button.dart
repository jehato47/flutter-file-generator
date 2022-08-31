import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgs_app/provider/sgs_provider.dart';

import '../../provider/core_provider.dart';

class SaveXlsxButton extends StatefulWidget {
  const SaveXlsxButton({Key? key}) : super(key: key);

  @override
  State<SaveXlsxButton> createState() => _SaveXlsxButtonState();
}

class _SaveXlsxButtonState extends State<SaveXlsxButton> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Sgs>(context, listen: false);

    return ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();

        bool isValid = prov.xlsxFormKey.currentState!.validate();
        print(isValid);
        if (!isValid) return;

        // return;
        setState(() {
          isLoading = true;
        });
        prov.xlsxFormKey.currentState!.save();
        print(prov.xlsxFormData);

        await Provider.of<Core>(context, listen: false)
            .createXlsx(prov.xlsxFormData);
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Oluşturuldu indirme başlıyor"),
            backgroundColor: Colors.green,
          ),
        );

        final url = await Provider.of<Core>(context, listen: false)
            .getXlsxUrl(prov.xlsxFormData["vinNumber"]);

        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("files")
            .doc(prov.xlsxFormData["vinNumber"])
            .get();

        if (snapshot.exists)
          await FirebaseFirestore.instance
              .collection("files")
              .doc(prov.xlsxFormData["vinNumber"])
              .update({
            'xlsx': true,
            'carBrand': prov.xlsxFormData["carBrand"],
            'carModel': prov.xlsxFormData["carModel"],
            'carYear': prov.xlsxFormData["carYear"],
            'old': prov.xlsxFormData['old'],
            'country': prov.xlsxFormData['country'],
            'vinNumber': prov.xlsxFormData['vinNumber'],
            'url': url,
            'uid': auth.currentUser?.uid,
          });
        else {
          await FirebaseFirestore.instance
              .collection("files")
              .doc(prov.xlsxFormData["vinNumber"])
              .set({
            'pdf': false,
            'xlsx': true,
            'date': DateTime.now(),
            'carBrand': prov.xlsxFormData["carBrand"],
            'carModel': prov.xlsxFormData["carModel"],
            'carYear': prov.xlsxFormData["carYear"],
            'old': prov.xlsxFormData['old'],
            'country': prov.xlsxFormData['country'],
            'vinNumber': prov.xlsxFormData['vinNumber'],
            'url': url,
            'uid': auth.currentUser?.uid,
          });
        }
      },
      child: isLoading
          ? Center(
              child: SizedBox(
                height: 15.0,
                width: 15.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            )
          : Text("Oluştur"),
    );
  }
}
