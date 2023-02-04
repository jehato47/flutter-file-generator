import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sgs_app/firebase_options.dart';
import 'package:sgs_app/screens/detail_tab_screen.dart';
import 'package:sgs_app/screens/pick_spage_screen.dart';
import 'package:sgs_app/screens/profile_screen.dart';
import 'package:sgs_app/widgets/firebase.dart';

import 'helpers/localization.dart';
import 'provider/auth_provider.dart';
import 'provider/core_provider.dart';
import 'provider/sgs_provider.dart';
import 'screens/file_detail_screen.dart';
import 'widgets/home/auth_gate.dart';
import 'widgets/manage_form.dart';

Future<void> main() async {
  // Flutter Version 2.10.3
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

        debugShowCheckedModeBanner: false,
        title: 'SGS GENERATOR',
        home: Scaffold(
          body: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
              // name: "initial",
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (snapshot.hasData) {
                return AuthGate();
              }

              return Container();
            },
          ),
        ),
        // home: AuthGate(),
        routes: {
          FileDetailScreen.url: (context) => FileDetailScreen(),
          ManageForm.url: (context) => ManageForm(),
          ProfileScreen.url: (context) => ProfileScreen(),
          PickSecondPageScreen.url: (context) => PickSecondPageScreen(),
          DetailTabScreen.url: (context) => DetailTabScreen(),
        },
      ),
    );
  }
}
