import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';

class FileListScreen extends StatefulWidget {
  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("files")
          .where(
            "uid",
            isEqualTo: auth.currentUser.uid,
          )
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        final data = snapshot.data.docs;
        if (data.length == 0) {
          return Center(
            child: Text(
              "Henüz dosya yok. Oluşturuğunuz dosyaları burada görebilirsiniz.",
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => Slidable(
            actions: [
              if (data[index].data().containsKey("pdfUrl"))
                IconSlideAction(
                  caption: "pdf",
                  icon: Icons.assignment,
                  color: Colors.red,
                  onTap: () async {
                    await Provider.of<Core>(context, listen: false)
                        .getPdfUrl(data[index]["vinNumber"]);
                  },
                ),
              if (data[index].data().containsKey("url"))
                IconSlideAction(
                  caption: "xlsx",
                  icon: Icons.assignment,
                  color: Colors.green,
                  onTap: () async {
                    await Provider.of<Core>(context, listen: false)
                        .getXlsxUrl(data[index]["vinNumber"]);
                  },
                ),
            ],
            child: ListTile(
              title: Text(data[index]["vinNumber"]),
            ),
            actionPane: SlidableDrawerActionPane(),
          ),
        );
      },
    );
  }
}
