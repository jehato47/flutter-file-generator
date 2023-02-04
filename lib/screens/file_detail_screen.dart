import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sgs_app/provider/sgs_provider.dart';

import '../widgets/mail_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helpers/truncate_string.dart';
import 'map_screen.dart';

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
    // print(haveXlsx);
    // print(havePdf);
    // bool pdfon = havePdf;
    // bool xlsxon = haveXlsx;
    // print(args.data());
    // print(args.length);
    List xlsx = [];
    List pdf = [];
    if (havePdf) {
      pdf = [
        // Text(
        //   "Pdf Bilgileri",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(fontSize: 20),
        // ),
        // Divider(),

        Card(
          child: ListTile(
              title: Text(args["contactPerson"]), trailing: Text("Aracı Kişi")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        Card(
          child: ListTile(
              trailing: Text("Oluşturma Tarihi"),
              title: Text(
                DateFormat().add_yMMMMd().format(args["date"].toDate()),
              )),
        ),
        Card(
          child: ListTile(title: Text(args["email"]), trailing: Text("Email")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        Card(
          child: ListTile(
            onLongPress: () async {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Haritada Gösteriliyor"),
                  backgroundColor: Colors.green));
              await Provider.of<Sgs>(context, listen: false)
                  .showInMap(context, args["exporterAddress"].toString());
            },
            trailing: Text("İhracatçı Adres"),
            title: Text(args["exporterAddress"].toString().truncate(max: 30)),
            // style: TextStyle(fontSize: 20),
          ),
        ),
        Card(
          child: ListTile(
              title: Text(args["exporterCompany"].toString().truncate(max: 30)),
              trailing: Text("İhracatçı Firma")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        Card(
          child: ListTile(
            title: Text(args["importerAddress"].toString().truncate(max: 30)),
            trailing: Text("İthalatçı Adres"),
            // onTap: () async {
            //   await Provider.of<Sgs>(context, listen: false)
            //       .showInMap(context, args["exporterAddress"].toString());
            // },
            // style: TextStyle(fontSize: 20),
          ),
        ),
        Card(
          child: ListTile(
              title: Text(args["importerCompany"].toString().truncate(max: 30)),
              trailing: Text("İthalatçı Firma")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        Card(
          child: ListTile(
              title: Text(args["invoiceNoDate"]),
              trailing: Text("Fatura No/Tarih")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        // ListTile(
        //   trailing: Text(args["pdfUrl"]),
        //   // trailing:Text("pdfUrl")
        //   // style: TextStyle(fontSize: 20),
        // ),
        Card(
          child: ListTile(title: Text(args["phone"]), trailing: Text("Telefon")
              // style: TextStyle(fontSize: 20),
              ),
        ),
        Card(
          child: ListTile(
              title: Text(args["vinNumber"]), trailing: Text("Vin Numarası")
              // style: TextStyle(fontSize: 20),
              ),
        ),
      ];
    }

    if (haveXlsx) {
      xlsx = [
        // SizedBox(height: 30),
        // Text(
        //   "Excel Bilgileri",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(fontSize: 20),
        // ),
        // Divider(),
        Card(
          child: ListTile(
            title: Text(args["carBrand"]),
            trailing: Text("Araç Marka"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(args["carModel"]),
            trailing: Text("Araç Model"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(args["carYear"]),
            trailing: Text("Araç Yıl"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(args["country"]),
            trailing: Text("Ülke"),
          ),
        ),
        Card(
          child: ListTile(
            title:
                Text(DateFormat().add_yMMMMd().format(args["date"].toDate())),
            trailing: Text("Tarih"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(args["old"]),
            trailing: Text("Yaş"),
          ),
        ),
        // ListTile(
        //   title: Text(args["url"]),
        //   trailing: Text("url"),
        // ),
        Card(
          child: ListTile(
            title: Text(args["vinNumber"]),
            trailing: Text("Vin Numarası"),
          ),
        ),
      ];
    }
    return Scaffold(
        // appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       await showDialog(
        //         context: context,
        //         builder: (context) => MailDialog(args),
        //       );
        //     },
        //     icon: FaIcon(FontAwesomeIcons.envelope),
        //   ),
        // ],
        // ),
        body: DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // floatingActionButton: const FloatingButtons(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => MailDialog(args),
                );
              },
              icon: FaIcon(FontAwesomeIcons.envelope),
            ),
          ],
          centerTitle: true,
          title: const Text("Sgs Düzenleyici"),
          bottom: TabBar(
            onTap: (index) {},
            tabs: const [
              Tab(text: "Pdf"),
              Tab(text: "Excel"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              // child: Text("qwe"),
              child: Column(
                children: [
                  Expanded(
                    child: havePdf
                        ? ListView(
                            children: [
                              ...pdf,
                              // if (haveXlsx) ...xlsx,
                            ],
                          )
                        : Center(child: Text("Pdf Bilgileri Bulunamadı")),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              // child: Text("qwe"),
              child: Column(
                children: [
                  Expanded(
                    child: haveXlsx
                        ? ListView(
                            children: [
                              // if (havePdf) ...pdf,

                              ...xlsx,
                            ],
                          )
                        : Center(
                            child: Text("Excel Bilgisi Yok"),
                          ),
                  )
                ],
              ),
            ),
            // DogsList(),
            // if (havePdf) ...pdf,
            // if (!havePdf) Scaffold(),

            // if (!haveXlsx) Scaffold(),
            // if (haveXlsx) ...xlsx,
            // BreedsList(),
          ],
        ),
      ),
    )
        // Padding(
        //       padding: EdgeInsets.all(20),
        //       // child: Text("qwe"),
        //       child: Column(
        //         children: [
        //           Expanded(
        //             child: ListView(
        //               children: [
        //                 if (havePdf) ...pdf,
        //                 if (haveXlsx) ...xlsx,
        //               ],
        //             ),
        //           )
        //         ],
        //       ),
        //     )
        );
  }
}
