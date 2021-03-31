import 'package:e_doctors/chat.dart';
import 'package:e_doctors/login.dart';
import 'package:e_doctors/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:e_doctors/getstarted.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: GetStarted(),
      routes: {
        '/' : (ctx) => GetStarted(),
        '/chat': (ctx) => Chat(),
        '/login': (ctx) => Login(),
        '/register': (ctx) => Register(),
      },
    );
  }
}
