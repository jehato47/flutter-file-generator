import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/core_provider.dart';

class XlsxForm extends StatefulWidget {
  @override
  _XlsxFormState createState() => _XlsxFormState();
}

class _XlsxFormState extends State<XlsxForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> formData = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text("Excel File Info"),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carBrand"] = newValue;
              },
              decoration: InputDecoration(labelText: "car brand"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carModel"] = newValue;
              },
              decoration: InputDecoration(labelText: "car model"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["carYear"] = newValue;
              },
              decoration: InputDecoration(labelText: "car year"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["old"] = newValue;
              },
              decoration: InputDecoration(labelText: "old"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["country"] = newValue;
              },
              decoration: InputDecoration(labelText: "country"),
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              onSaved: (newValue) {
                formData["vinNumber"] = newValue;
              },
              decoration: InputDecoration(labelText: "vin number"),
            ),
            SizedBox(height: 10),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      _formKey.currentState.save();
                      print(formData);

                      await Provider.of<Core>(context).createXlsx(formData);
                      setState(() {
                        isLoading = false;
                      });
                      await Provider.of<Core>(context)
                          .getXlsxUrl(formData["vinNumber"]);
                    },
                    child: Text("btn"),
                  )
          ],
        ),
      ),
    );
  }
}
