import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/cart.dart';
import 'package:retrive_data/login.dart';
import 'package:retrive_data/notification.dart';
import 'package:retrive_data/phone_call.dart';
import 'package:retrive_data/product.dart';
import 'package:retrive_data/profile_screen.dart';
import 'home.dart';

class NaviBottom extends StatefulWidget {
  @override
  _NaviBottomState createState() => _NaviBottomState();
}

class _NaviBottomState extends State<NaviBottom> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    Phone_Call(),
    Notification_Page(),
    Profile_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.call), label: 'call'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }
      ),
    );
  }
}