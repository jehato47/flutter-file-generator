import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../screens/map_screen.dart';

class FirebaseScreen extends StatefulWidget {
  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  int index = 0;
  FirebaseAuth auth = FirebaseAuth.instance;

  String currentText = "";
  TextEditingController _controller = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  LatLng latLng = LatLng(0, 0);

  @override
  Widget build(BuildContext context) {
    Map<String, String> companies = {
      "Truckland Aps": "Højbjerg Huse 7, 8840 Rødkærsbro, Danimarka",
      "Hoplog Oy": "Keskikankaantie 28, 15860 Hollola, Finlandiya",
    };
    List<String> sugg = companies.keys.toList();
    // List<String> add = companies.values.toList();
    bool isLoading = false;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Firebase"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("files")
                .where(
                  "uid",
                  isEqualTo: auth.currentUser?.uid,
                )
                .orderBy("date", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final data = (snapshot.data as QuerySnapshot).docs;
              if (data.length == 0) {
                return Center(
                  child: Text(
                    "Henüz dosya yok. Oluşturuğunuz dosyaları burada görebilirsiniz.",
                    textAlign: TextAlign.center,
                  ),
                );
              }
              List<String> addresses = data
                  .map((e) {
                    // companies[e["exporterCompany"]] = e["exporterAddress"];
                    return e["exporterAddress"].toString();
                  })
                  .toSet()
                  .toList();

              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                      child: Text((addresses.length - index).toString())),
                  title: Text(addresses[index]),
                  onTap: () async {
                    {
                      var googleGeocoding = GoogleGeocoding(
                          "AIzaSyC1VRXx_dWi58eIf-lWpIwtA5ClJYlAoDw");
                      var risult = await googleGeocoding.geocoding
                          .get(data[index]["exporterAddress"], []);

                      print(risult!.results![0].geometry!.location!.lng);
                      // setState(() {
                      latLng = LatLng(
                        risult.results![0].geometry!.location!.lat!,
                        risult.results![0].geometry!.location!.lng!,
                      );
                      // });
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return MapScreen(
                            latLng: latLng,
                          );
                        },
                      ));
                    }
                  },
                ),
                itemCount: data.length,
              );
              return Center(
                child: ElevatedButton(
                  child: Text("123123"),
                  onPressed: () async {
                    var googleGeocoding = GoogleGeocoding(
                        "AIzaSyC1VRXx_dWi58eIf-lWpIwtA5ClJYlAoDw");
                    var risult = await googleGeocoding.geocoding.get(
                        "Mühlweg 3a, 67105 Schifferstadt, Deutschland", []);

                    print(risult!.results![0].geometry!.location!.lng);
                    // setState(() {
                    latLng = LatLng(
                      risult.results![0].geometry!.location!.lat!,
                      risult.results![0].geometry!.location!.lng!,
                    );
                    // });
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return MapScreen(
                          latLng: latLng,
                        );
                      },
                    ));
                  },
                ),
              );
            }),
      ),
    );
  }
}
