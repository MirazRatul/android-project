import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/bottom_bar.dart';
import 'package:retrive_data/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:retrive_data/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

Future<void> backgroundHandler(RemoteMessage message) async{
  print("This is message from background");
  print(message.notification!.title);
  print(message.notification!.body);
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp
    (home: email == null ?  Login_page() : NaviBottom()));
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Login_page(),
      ),
      designSize: const Size(720,1080),
    );
  }
}