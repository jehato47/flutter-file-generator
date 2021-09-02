import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_responsive/provider/auth_provider.dart';
import 'package:school_responsive/provider/sgs_provider.dart';
import 'sgs_form.dart';
import 'provider/core_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_navbar.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Core(),
        ),
        ChangeNotifierProvider(
          create: (context) => Sgs(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
            // primaryColorDark: Colors.red,
            // brightness: Brightness.dark,
            // accentColor: Colors.amber,
            // buttonColor: Colors.indigo,
            ),
        routes: {
          FileDetailScreen.url: (context) => FileDetailScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: 'SGS GENERATOR',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return Container();
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              if (FirebaseAuth.instance.currentUser == null)
                return LoginScreen();
              else
                return BottomNavbarScreen();
              return StreamBuilder(
                // TODO: login, logout, signup yapıldıgında bu stream değişecek
                // TODO: onAuthstateChanged -> authStateChanges
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (ctx, snapshot) {
                  // FirebaseAuth.instance.signOut();
                  // * TODO : Login Form da setState hatası veriyor bak
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator());
                  // if (snapshot.hasData) {
                  //   // todo : Öğrenci ve Öğretmen eklerken resim urlsini ekle de kaydet
                  //   // todo : Yoklama Ekranında Öğreninin detaylarını göstermeyi hallet
                  //   // todo : Sınav sonuç ekranında detay pop-up ını bitir
                  //   // ? todo : Sınav cevap kağıdını göstermeyi hallet
                  //   return LoginScreen();
                  // }

                  return LoginScreen();
                },
              );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        title: Text("Sgs Generator"),
      ),
      body: SgsForm(),
    );
  }
}
