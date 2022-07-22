import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/bottom_bar.dart';
import 'package:retrive_data/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class Login_page extends StatefulWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {


  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseException catch (e){
      if(e.code == "user-not-found"){
        print("No User found for that email");
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade200,
                Colors.orange.shade200,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to your profile',
                    style: TextStyle(color: Colors.black, fontSize: 44.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 44.0,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "name@gmail.com",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                      prefixIcon: Icon(Icons.mail,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black,width: 3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "User Password",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                      prefixIcon: Icon(Icons.lock,color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.black,width: 3),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          "Don't have any account?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        GestureDetector(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                            ),
                          ),
                          onTap: (){
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => const Registration()));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    width: 150,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF0069FE),
                      elevation: 0.0,
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      onPressed: () async{
                        User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                        print(user);
                        if(user !=null) {
                          SharedPreferences prefs = await SharedPreferences
                              .getInstance();
                          prefs.setString('email', _emailController.text);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => NaviBottom()));
                        }
                      },
                      child: Text("Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}