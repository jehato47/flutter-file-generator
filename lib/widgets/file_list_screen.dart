import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'file_detail_screen.dart';
import 'file_item.dart';
import 'manage_form.dart';
import 'pdf/pdf_screen.dart';
import '../provider/core_provider.dart';

class FileListScreen extends StatefulWidget {
  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // Intl.defaultLocale = 'tr';

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("files")
          .where(
            "uid",
            isEqualTo: auth.currentUser?.uid,
          )
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data == null) return Container();

        final data = (snapshot.data as QuerySnapshot).docs;
        if (data.length == 0) {
          return Center(
            child: Text(
              "Henüz dosya yok. Oluşturuğunuz dosyaları burada görebilirsiniz.",
              textAlign: TextAlign.center,
            ),
          );
        }
        bool isScreenWide = MediaQuery.of(context).size.width > 700;
        return Padding(
          padding: EdgeInsets.all(isScreenWide && kIsWeb ? 10 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (kIsWeb && isScreenWide)
                Text(
                  "Olusturduğunuz Dosyalar",
                  style: TextStyle(fontSize: 20),
                ),
              if (kIsWeb && isScreenWide) Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) => FileItem(
                    item: data[index],
                    number: data.length - index,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
