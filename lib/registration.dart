import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  //final url = 'https://st2.depositphotos.com/3591429/7158/i/600/depositphotos_71584499-stock-photo-register-of-membership-concept.jpg';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  userRegistration() async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: _email.text, password: _password.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential!.uid.isNotEmpty){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_page()));
      } else{
        Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            fontSize: 16.0);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if(e.code == 'email-already-in-use'){
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    }catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.shade200,
                Colors.teal.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Your Own Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 44,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Container(
                    height: 60,
                    child: TextFormField(
                      controller: _email,
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                          hintText: 'Enter Your Valid Email',
                          hintStyle:
                          TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black,width: 3),
                            borderRadius: BorderRadius.circular(20),
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: TextFormField(
                        controller: _password,
                        style: const TextStyle(fontSize: 18, color: Colors.black),
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle:
                            TextStyle(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black,width: 3),
                              borderRadius: BorderRadius.circular(20),
                            )
                        )
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),

                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(150,50)
                    ),
                    onPressed: () {
                      userRegistration();
                    },
                    icon: const Icon(Icons.app_registration_outlined,color: Colors.black,),
                    label: const Text('Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),),
                  SizedBox(
                    height:20,
                  ),
                  Row(
                    children: [
                      Text('Already have an Account? ',
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                      GestureDetector(
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Login_page()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
