import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/bottom_bar.dart';
import 'package:retrive_data/product_details_screen.dart';
import 'cart.dart';

class Product_Page extends StatefulWidget {
  const Product_Page({Key? key}) : super(key: key);

  @override
  _Product_PageState createState() => _Product_PageState();
}

class _Product_PageState extends State<Product_Page> {
  List _products = [];

  fetchProducts() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "name": qn.docs[i]["name"],
          "price": qn.docs[i]["price"],
          "image": qn.docs[i]["image"],
        });
      }
    });
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: Text(
          'Products',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: IconButton(
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back),
          ),
        ),
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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.8),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AspectRatio(
                                aspectRatio: 1.2,
                                child:
                                Image.network(_products[index]["image"])),
                            Text(
                              "${_products[index]["name"]}",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                                "BDT ${_products[index]["price"]}"),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
