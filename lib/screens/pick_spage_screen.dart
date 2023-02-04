import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickSecondPageScreen extends StatelessWidget {
  static const url = "pick-second-page";
  const PickSecondPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("")),
          Spacer(),
          ElevatedButton(
              onPressed: () async {
                var result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
              },
              child: Text("123123"))
        ],
      ),
    );
  }
}
