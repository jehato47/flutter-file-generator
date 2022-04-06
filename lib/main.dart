import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:school_responsive/widgets/firebase_login.dart';

import 'helpers/localization.dart';
import 'provider/auth_provider.dart';
import 'provider/core_provider.dart';
import 'provider/sgs_provider.dart';
import 'widgets/bottom_navbar.dart';
import 'widgets/file_detail_screen.dart';
import 'widgets/login_screen.dart';
import 'widgets/manage_form.dart';
import 'widgets/sgs_form.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'tr_TR';

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        darkTheme: FlexThemeData.dark(scheme: FlexScheme.greyLaw),
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        localizationsDelegates: [
          FlutterFireUILocalizations.withDefaultOverrides(
            LabelOverrides(),
          ),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          FlutterFireUILocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr'),
          Locale('en'),
        ],
        locale: const Locale('tr'),
        routes: {
          FileDetailScreen.url: (context) => FileDetailScreen(),
          ManageForm.url: (context) => ManageForm(),
        },
        debugShowCheckedModeBanner: false,
        title: 'SGS GENERATOR',
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (FirebaseAuth.instance.currentUser == null)
                return FirebaseLoginScreen();
              else
                return BottomNavbarScreen();
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
