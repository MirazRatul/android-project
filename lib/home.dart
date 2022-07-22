import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/phone_call.dart';
import 'package:retrive_data/product.dart';
import 'package:retrive_data/search_screen.dart';

import 'bottom_bar.dart';
import 'cart.dart';
import 'gents.dart';
import 'kids.dart';
import 'ladies.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,

        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Cart()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      )
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black,
                      )
                  ),
                  hintText: 'Search products here',
                  hintStyle: TextStyle(fontSize: 15),
                ),
                onTap: () =>
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => Search_Screen())),
              ),
            ),

            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              height: 250.0,
              child: Gents(),
            ),

            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              height: 250.0,
              child: Ladies(),
            ),

            Container(
              margin:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              height: 250.0,
              child: Kids(),
            ),


            Container(
              width: 180,
              child: RawMaterialButton(
                fillColor: Colors.orange.shade100,
                elevation: 5.0,
                padding: EdgeInsets.symmetric(vertical: 12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Product_Page(),
                    ),
                  );
                },
                child: Text("See All Products",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
