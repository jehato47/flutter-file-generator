import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sgs_app/screens/showImageScreen.dart';
import 'package:sgs_app/widgets/firebase.dart';
import 'package:sgs_app/widgets/home/auth_gate.dart';

class ProfileScreen extends StatelessWidget {
  static const url = "profile";
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    const photos = [
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_06.coreimg.82.1024.jpeg/1530611184209/1860x1050-18-driving-wheel.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_07.coreimg.82.1024.jpeg/1530611179593/1860x1050-17-driving-road-snow.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_09.coreimg.82.1024.jpeg/1530611171676/1860x1050-15-visibility.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_010.coreimg.82.1024.jpeg/1530611161284/1860x1050-14-escape-hatch.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_013.coreimg.82.1024.jpeg/1530611142441/1860x1050-11-adaptive-cruise-control.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_014.coreimg.82.1024.jpeg/1530611136566/1860x1050-10-lane-keeping-support.jpeg",
      "https://www.volvotrucks.com.tr/tr-tr/news/magazine-online/2018/jul/25-volvo-fh-safety-features/_jcr_content/root/responsivegrid/image_015.coreimg.82.1024.jpeg/1530611130300/1860x1050-9-quality-tests.jpeg",
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Profil"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: FaIcon(
              FontAwesomeIcons.times,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(photos[Random().nextInt(photos.length)]),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: user.photoURL != null
                  ? Hero(
                      tag: user.photoURL!,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    )
                  : CircleAvatar(
                      child: FaIcon(
                        FontAwesomeIcons.user,
                      ),
                    ),
              accountName: Text(
                user.email ?? "Kayıtlı email yok",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                "Etp Panorama",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ShowImageScreen();
                      },
                    ));
                  },
                  title: Text("Faturam"),
                  trailing: FaIcon(FontAwesomeIcons.fileImage),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return FirebaseScreen();
                      },
                    ));
                  },
                  title: Text("Adresler"),
                  trailing: FaIcon(FontAwesomeIcons.searchLocation),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).primaryColor, width: 0.4),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red, width: 0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          final isSignedIn = await GoogleSignIn().isSignedIn();
                          if (isSignedIn) await GoogleSignIn().signOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("Çıkış Yaptınız"),
                            ),
                          );
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => LoginScreen(),
                          // ));
                          await Future.delayed(Duration(seconds: 1));

                          Navigator.of(context).pop();
                        },
                        title: Text("Çıkış Yap"),
                        trailing: FaIcon(FontAwesomeIcons.signOutAlt),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
