import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:school_responsive/file_detail_screen.dart';
import 'package:school_responsive/file_item.dart';
import 'package:school_responsive/manage_form.dart';
import 'package:school_responsive/pdf_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'provider/core_provider.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

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
            isEqualTo: auth.currentUser.uid,
          )
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        if (snapshot.data == null) return Container();

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
          itemBuilder: (context, index) => FileItem(
            item: data[index],
            number: data.length - index,
          ),
        );
      },
    );
  }
}
