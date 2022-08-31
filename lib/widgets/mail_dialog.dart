import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MailDialog extends StatefulWidget {
  final dynamic args;
  MailDialog(this.args);

  @override
  _MailDialogState createState() => _MailDialogState();
}

class _MailDialogState extends State<MailDialog> {
  bool showErrorText = false;
  String? msg;

  void selectMessage() {
    bool haveXlsx = args["xlsx"];
    bool havePdf = args["pdf"];
    if (xlsxon && pdfon) {
      msg = '''<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>

	<div >

	<a href=${args["pdfUrl"]}>
		Sgs Pdf File
		Click to download		
	</a>
	<br>
	<a href=${args["url"]}>
		Sgs Excel File
		Click to download		
	</a>


	</div>

</body>
</html>
      ''';
    } else if (pdfon) {
      msg = '''<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>

	<div >

	<a href=${args["pdfUrl"]}>
		Sgs Pdf File
		Click to download		
	</a>



	</div>

</body>
</html>
      ''';
    } else if (xlsxon) {
      msg = '''<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>

	<div >


	<a href=${args["url"]}>
		Sgs Excel File
		Click to download		
	</a>


	</div>

</body>
</html>
      ''';
    }
  }

  TextEditingController _controller = TextEditingController();
  bool pdfon = false;
  bool xlsxon = false;
  dynamic args;
  @override
  Widget build(BuildContext context) {
    args = widget.args;
    bool haveXlsx = args["xlsx"];
    bool havePdf = args["pdf"];

    // bool pdfon = args["xlsx"];
    // bool xlsxon = args["pdf"];

    return AlertDialog(
      content: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField(
            //   keyboardType: TextInputType.emailAddress,
            //   controller: _controller,
            //   decoration: InputDecoration(hintText: "email"),
            // ),
            if (havePdf)
              CheckboxListTile(
                secondary: Icon(
                  Icons.assignment,
                  color: Colors.red,
                ),
                title: Text("pdf"),
                value: pdfon,
                onChanged: (value) {
                  if (havePdf) {
                    setState(() {
                      pdfon = !pdfon;
                    });
                  }
                },
              ),
            if (haveXlsx)
              CheckboxListTile(
                title: Text("xlsx"),
                secondary: Icon(
                  Icons.assignment,
                  color: Colors.green,
                ),
                value: xlsxon,
                onChanged: (value) {
                  if (haveXlsx) {
                    setState(() {
                      xlsxon = !xlsxon;
                    });
                  }
                },
              ),
            if (!pdfon & !xlsxon & showErrorText)
              Text(
                "Seçim Yapmadınız",
                style: TextStyle(color: Theme.of(context).hintColor),
              ),
            ElevatedButton(
                onPressed: () async {
                  if (!pdfon & !xlsxon) {
                    setState(() {
                      showErrorText = true;
                    });
                    return;
                  }

                  selectMessage();
                  await FirebaseFirestore.instance.collection("mail").add({
                    "to": [FirebaseAuth.instance.currentUser?.email],
                    "message": {
                      "subject": 'SGS REGISTRATION',
                      "text": 'Selam',
                      "html": msg,
                    }
                  });

                  print("sent");
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Başarıyla Gönderildi"),
                      duration: Duration(milliseconds: 1000),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text("Mailime gönder"))
          ],
        ),
      ),
    );
  }
}
