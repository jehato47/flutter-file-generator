import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'file_detail_screen.dart';
import 'pdf_screen.dart';
import 'provider/core_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'manage_form.dart';

class FileItem extends StatelessWidget {
  final dynamic item;
  final int number;
  const FileItem({Key key, this.item, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actions: [
        if (item.data().containsKey("pdfUrl"))
          IconSlideAction(
            caption: "pdf",
            icon: Icons.assignment,
            color: Colors.red,
            onTap: () async {
              final url = await Provider.of<Core>(context, listen: false)
                  .getPdfUrl(item["vinNumber"]);
              if (!kIsWeb) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PdfViewScreen(url: url),
                ));
              } else {
                await launch(url);
              }
            },
          ),
        if (item.data().containsKey("url"))
          IconSlideAction(
            caption: "xlsx",
            icon: Icons.assignment,
            color: Colors.green,
            onTap: () async {
              await Provider.of<Core>(context, listen: false)
                  .getXlsxUrl(item["vinNumber"]);
            },
          ),
      ],
      secondaryActions: [
        // if (item.data().containsKey("pdfUrl"))
        IconSlideAction(
          caption: "Sil",
          icon: Icons.assignment,
          color: Colors.amber,
          onTap: () async {
            var a = 0;
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text("Kesin mi?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      a = 1;
                      Navigator.of(context).pop();
                    },
                    child: Text("evet"),
                  ),
                  TextButton(
                    onPressed: () {
                      a = 0;
                      Navigator.of(context).pop();
                    },
                    child: Text("hayır"),
                  ),
                ],
              ),
            );

            if (a == 1) {
              final vin = item["vinNumber"];
              if (item.data().containsKey("pdfUrl"))
                await FirebaseStorage.instance.ref("$vin/$vin.pdf").delete();

              if (item.data().containsKey("url"))
                await FirebaseStorage.instance.ref("$vin/$vin.xlsx").delete();

              await FirebaseFirestore.instance
                  .collection("files")
                  .doc(vin)
                  .delete();
            }
          },
        ),
        // if (data[ind].data().containsKey("url"))
        //   IconSlideAction(
        //     caption: "delete xlsx",
        //     icon: Icons.assignment,
        //     color: Colors.teal,
        //     onTap: () async {},
        //   ),
      ],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey[300],
          child: Text(
            number.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
        onLongPress: () {
          Navigator.of(context).pushNamed(ManageForm.url, arguments: item);
        },
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //   builder: (context) => ManageForm(),
          // ));

          // return;
          Navigator.of(context)
              .pushNamed(FileDetailScreen.url, arguments: item);
        },
        title: Text(
          item["xlsx"]
              ? item["carBrand"] + " " + item["carModel"]
              : item["exporterAddress"],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(item["vinNumber"]),
        trailing: Text(DateFormat().add_yMd().format(item["date"].toDate())),
      ),
      actionPane: SlidableDrawerActionPane(),
    );
  }
}
