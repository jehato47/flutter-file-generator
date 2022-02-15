import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_responsive/firebase.dart';
import 'package:school_responsive/manage_form.dart';
import 'package:school_responsive/provider/auth_provider.dart';
import 'package:school_responsive/provider/sgs_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'sgs_form.dart';
import 'provider/core_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_navbar.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file_detail_screen.dart';
import 'dart:io';
import 'package:intl/intl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'tr_TR';
  // if (Platform.isAndroid) {
  //   // await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }

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
        // theme: FlexThemeData.light(scheme: FlexScheme.greyLaw),
        // The Mandy red, dark theme.
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.greyLaw),
        themeMode: ThemeMode.dark,
        // theme: FlexThemeData.light(scheme: FlexScheme.aquaBlue),
        // darkTheme: ThemeData.dark().copyWith(),
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,

          // ... app-specific localization delegate[s] here
          // SfGlobalLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('tr'),
          // ... other locales the app supports
        ],
        // ignore: always_specify_types
        // supportedLocales:
        //
        locale: const Locale('tr'),
        routes: {
          FileDetailScreen.url: (context) => FileDetailScreen(),
          ManageForm.url: (context) => ManageForm(),
        },
        debugShowCheckedModeBanner: false,
        title: 'SGS GENERATOR',

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
              // return StreamBuilder(
              //   // TODO: login, logout, signup yapıldıgında bu stream değişecek
              //   // TODO: onAuthstateChanged -> authStateChanges
              //   stream: FirebaseAuth.instance.authStateChanges(),
              //   builder: (ctx, snapshot) {
              //     // FirebaseAuth.instance.signOut();
              //     // * TODO : Login Form da setState hatası veriyor bak
              //     if (snapshot.connectionState == ConnectionState.waiting)
              //       return Center(child: CircularProgressIndicator());
              //     // if (snapshot.hasData) {
              //     //   // todo : Öğrenci ve Öğretmen eklerken resim urlsini ekle de kaydet
              //     //   // todo : Yoklama Ekranında Öğreninin detaylarını göstermeyi hallet
              //     //   // todo : Sınav sonuç ekranında detay pop-up ını bitir
              //     //   // ? todo : Sınav cevap kağıdını göstermeyi hallet
              //     //   return LoginScreen();
              //     // }

              //     return LoginScreen();
              //   },
              // );
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
        title: Text("Sgs Düzenleyici"),
      ),
      body: SgsForm(),
    );
  }
}
