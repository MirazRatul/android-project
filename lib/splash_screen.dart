import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/bottom_bar.dart';
import 'package:retrive_data/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder:(context)=>NaviBottom()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Center(
              child: Text(
                'E-Shop',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Center(
              child: Text(
                'An E-Commerce App',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade200,
                Colors.teal.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
      ),
    );
  }
}