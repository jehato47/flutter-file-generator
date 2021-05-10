import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sgs_form.dart';
import 'provider/core_provider.dart';
import 'provider/try_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bottom_navbar.dart';

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
          create: (context) => Try(),
        ),
      ],
      child: MaterialApp(
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
              return BottomNavbarScreen();
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
