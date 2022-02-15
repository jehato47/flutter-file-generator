import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewScreen extends StatefulWidget {
  final String url;
  const PdfViewScreen({Key key, this.url}) : super(key: key);

  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    final url = widget.url;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              await launch(url);
            },
          )
        ],
      ),
      body: Center(
        child: SfPdfViewer.network(
          url,
          // enableTextSelection: true,
          // interactionMode: PdfInteractionMode.selection,
        ),
      ),
    );
  }
}
