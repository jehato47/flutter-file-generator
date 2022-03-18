import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/person.dart';
import 'provider/form_provider.dart';

class PickContactPerson extends StatelessWidget {
  const PickContactPerson({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FormProvider>(context, listen: false);
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("contactPersons").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> docs = querySnapshot.docs;

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Aracı Kişiyi Seçin",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                spacing: 10,
                children: [
                  ...docs
                      .map(
                        (person) => buildPerson(
                          Person(
                            id: person.id,
                            name: person["name"],
                            email: person["email"],
                            phoneNumber: person["phoneNumber"],
                            logistic: person["logistic"],
                            addedDate: person["addedDate"].toDate(),
                          ),
                        ),
                      )
                      .toList(),
                  // buildPerson(
                  //   Person(
                  //     // id: "1",
                  //     name: "Kendal Deniz",
                  //     logistic: "Kendal Deniz Logistic",
                  //     email: "kendalkendalo@hotmail.com",
                  //     phoneNumber: "01",
                  //   ),
                  // ),
                  // buildPerson(
                  //   Person(
                  //     // id: "2",
                  //     name: "Israfil Caglar Solgun",
                  //     logistic: "ICS Logistic",
                  //     email: "caglars@hotmail.de",
                  //     phoneNumber: "02",
                  //   ),
                  // ),
                ],
              ),
            ],
          );
        });
  }

  Consumer buildPerson(Person person) {
    return Consumer<FormProvider>(
      builder: (context, value, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: () async {
            // value.addContactPerson(person);
            value.changePickedPerson(person);
            Navigator.of(context).pop();
          },
          child: Card(
            margin: EdgeInsets.all(4),
            color: value.pickedPerson?.id == person.id
                ? Theme.of(context).buttonTheme.colorScheme.primary
                : Theme.of(context).cardTheme.color,
            child: ListTile(
              title: Text(person.name),
              subtitle: Text(person.email),
              // trailing: Text(person.logistic),
            ),
          ),
        ),
      ),
    );
  }
}
