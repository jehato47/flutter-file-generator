import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseScreen extends StatefulWidget {
  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("gönder"),
          onPressed: () async {
            await FirebaseFirestore.instance.collection("messages").add({
              "channelId": 'dc219ce8777e46a388115fa3a1559bbe',
              "to": '5366639292',
              "type": 'text',
              "content": {"text": 'YOUR_MESSAGE_CONTENT'}
            });

            return;
            await FirebaseFirestore.instance.collection("mail").add({
              "to": ['jehatdeniz@hotmail.com'],
              "message": {
                "subject": 'SGS REGISTRATION',
                "text": 'Selam',
                "html": '''
                    
<html>
<head>
	<meta charset="utf-8">
	<title></title>
</head>
<body>

	<div >

	<a href="https://firebasestorage.googleapis.com/v0/b/sgs-create.appspot.com/o/W1K1183451N114434%2FW1K1183451N114434.pdf?alt=media&token=89acf770-21b1-4170-86bb-b9a1f442e327">
		Sgs Pdf File
		Click to download		
	</a>
	<br>
	<a href="https://firebasestorage.googleapis.com/v0/b/sgs-create.appspot.com/o/W1K1183451N114434%2FW1K1183451N114434.pdf?alt=media&token=89acf770-21b1-4170-86bb-b9a1f442e327">
		Sgs Excel File
		Click to download		
	</a>


	</div>

</body>
</html>
                    ''',
              }
            });

            print("sent");
          },
        ),
      ),
    );
  }
}
