import 'dart:io';
import 'mail_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FileDetailScreen extends StatefulWidget {
  static const url = "file-detail";
  @override
  _FileDetailScreenState createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as dynamic;
    bool haveXlsx = args["xlsx"];
    bool havePdf = args["pdf"];
    print(haveXlsx);
    print(havePdf);
    bool pdfon = havePdf;
    bool xlsxon = haveXlsx;
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
            trailing: Text(args["contactPerson"]), title: Text("contact person")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            title: Text("date"),
            trailing: Text(
              args["date"].toDate().toString(),
            )),
        ListTile(trailing: Text(args["email"]), title: Text("email")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["exporterAddress"]),
            title: Text("exporterAddress")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["exporterCompany"]),
            title: Text("exporterCompany")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["importerAddress"]),
            title: Text("importerAddress")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["importerCompany"]),
            title: Text("importerCompany")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(
            trailing: Text(args["invoiceNoDate"]), title: Text("invoiceNoDate")
            // style: TextStyle(fontSize: 20),
            ),
        // ListTile(
        //   title: Text(args["pdfUrl"]),
        //   // title:Text("pdfUrl")
        //   // style: TextStyle(fontSize: 20),
        // ),
        ListTile(trailing: Text(args["phone"]), title: Text("phone")
            // style: TextStyle(fontSize: 20),
            ),
        ListTile(trailing: Text(args["vinNumber"]), title: Text("vinNumber")
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
          title: Text("carBrand"),
        ),
        ListTile(
          trailing: Text(args["carModel"]),
          title: Text("carModel"),
        ),
        ListTile(
          trailing: Text(args["carYear"]),
          title: Text("carYear"),
        ),
        ListTile(
          trailing: Text(args["country"]),
          title: Text("country"),
        ),
        ListTile(
          trailing: Text(args["date"].toDate().toString()),
          title: Text("date"),
        ),
        ListTile(
          trailing: Text(args["old"]),
          title: Text("old"),
        ),
        // ListTile(
        //   trailing: Text(args["url"]),
        //   title: Text("url"),
        // ),
        ListTile(
          trailing: Text(args["vinNumber"]),
          title: Text("vinNumber"),
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
