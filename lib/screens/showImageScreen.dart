import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sgs_app/screens/pick_spage_screen.dart';

class ShowImageScreen extends StatelessWidget {
  static const url = "show-image";
  const ShowImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.teal[900],
            child: FaIcon(FontAwesomeIcons.fileUpload),
            onPressed: () async {
              var result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
            },
          ),
          SizedBox(width: 10),
          FloatingActionButton.extended(
            backgroundColor: Colors.teal[900],
            onPressed: () {},
            label: Text("Değiştir"),
          )
        ],
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //       icon: FaIcon(FontAwesomeIcons.arrowDown),
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //     ),
      //     IconButton(
      //       onPressed: () async {
      //         // Navigator.of(context).pushNamed(PickSecondPageScreen.url);
      //         var result = await FilePicker.platform.pickFiles(
      //           type: FileType.image,
      //         );
      //       },
      //       icon: FaIcon(
      //         FontAwesomeIcons.fileImport,
      //       ),
      //     )
      //   ],
      // ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Ukazkova_faktura.png/380px-Ukazkova_faktura.png",
          ),
        ),
      ),
    );
  }
}
