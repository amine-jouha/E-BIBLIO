import 'package:ebiblio/providers/addBook_provider.dart';
import 'package:ebiblio/providers/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ebiblio/controllers/google_signin_controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:ebiblio/getStarted/getStarted.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:ebiblio/leftMenu/Login.dart';

import 'getStarted/first_choice.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/welcome.dart';


Future<void> main() async {
  // ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();


  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //     apiKey: 'XijEUSw9BopmwHtllC4M3W8z0',
    //     appId: '1:93688306315:android:108c7f9af8c25f26e0d28e',
    //     messagingSenderId: '93688306315',
    //     projectId: 'revive-11dbb')
  );
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  // );
  // DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools
  //     ],
  //     builder: (context) =>  MyApp()
  // )
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginController()),
        ChangeNotifierProvider(create: (context) => addBookProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          // brightness: Brightness.dark
        ),
        home: FirstChoice(),
        // getStarted(),
      ),
    );
  }
}

