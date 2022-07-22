import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Column(
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 100, top: 70),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://static.toiimg.com/photo/72111166/Ranu-Mondal-pictures.jpg'),
                    ),
                    Positioned(
                      bottom: 20.0,
                      right: 20.0,
                        child: InkWell(
                          onTap: (){

                          },
                          child: Icon(
                             Icons.camera_alt,
                             color: Colors.red,
                             size: 40.0,
                          ),
                        ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: Text(
                'Ranu Mondol',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.black,
                  letterSpacing: 3,
                ),
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 110),
              child: FloatingActionButton.extended(
                label: Text('Log out'),
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.logout,
                  size: 24.0,
                ),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext ctx) => Login_page()));
                },
              ),
            ),
          ]
        ),
    );
  }
}
