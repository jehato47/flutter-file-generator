import 'dart:io';
import 'mail_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/truncate_string.dart';

class FileDetailScreen extends StatefulWidget {
  static const url = "file-detail";
  @override
  _FileDetailScreenState createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as dynamic;
    bool haveXlsx = args["xlsx"];
    bool havePdf = args["pdf"];
    print(haveXlsx);
    print(havePdf);
    // bool pdfon = havePdf;
    // bool xlsxon = haveXlsx;
    // print(args.data());
    // print(args.length);
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

        ListTile(
            trailing: Text(args["contactPerson"]), title: Text("Aracı Kişi")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            title: Text("Oluşturma Tarihi"),
            trailing: Text(
              DateFormat().add_yMMMMd().format(args["date"].toDate()),
            )),
        ListTile(trailing: Text(args["email"]), title: Text("Email")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
          title: Text("İhracatçı Adres"),
          trailing: Text(args["exporterAddress"].toString().truncate(max: 25)),
          // style: TextStyle(fontSize: 20),
        ),
        ListTile(
            trailing:
                Text(args["exporterCompany"].toString().truncate(max: 25)),
            title: Text("İhracatçı Firma")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing:
                Text(args["importerAddress"].toString().truncate(max: 25)),
            title: Text("İthalatçı Adres")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing:
                Text(args["importerCompany"].toString().truncate(max: 20)),
            title: Text("İthalatçı Firma")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["invoiceNoDate"]),
            title: Text("Fatura No/Tarih")
            // style: TextStyle(fontSize: 20),
            ),
        // ListTile(
        //   title: Text(args["pdfUrl"]),
        //   // title:Text("pdfUrl")
        //   // style: TextStyle(fontSize: 20),
        // ),
        ListTile(trailing: Text(args["phone"]), title: Text("Telefon")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(trailing: Text(args["vinNumber"]), title: Text("Vin Numarası")
            // style: TextStyle(fontSize: 20),
            ),
      ];
    }

    if (haveXlsx) {
      xlsx = [
        Text(
          "Xlsx Info",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Divider(),
        ListTile(
          trailing: Text(args["carBrand"]),
          title: Text("Araç Marka"),
        ),
        ListTile(
          trailing: Text(args["carModel"]),
          title: Text("Araç Model"),
        ),
        ListTile(
          trailing: Text(args["carYear"]),
          title: Text("Araç Yıl"),
        ),
        ListTile(
          trailing: Text(args["country"]),
          title: Text("Ülke"),
        ),
        ListTile(
          trailing:
              Text(DateFormat().add_yMMMMd().format(args["date"].toDate())),
          title: Text("Tarih"),
        ),
        ListTile(
          trailing: Text(args["old"]),
          title: Text("Old"),
        ),
        // ListTile(
        //   trailing: Text(args["url"]),
        //   title: Text("url"),
        // ),
        ListTile(
          trailing: Text(args["vinNumber"]),
          title: Text("Vin Numarası"),
        ),
      ];
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
                    if (havePdf) ...pdf,
                    if (haveXlsx) ...xlsx,
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
