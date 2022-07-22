import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/product_details_screen.dart';


class Kids extends StatefulWidget {
  const Kids({Key? key}) : super(key: key);

  @override
  _KidsState createState() => _KidsState();
}

class _KidsState extends State<Kids> {

  List _products = [];

  fetchProducts() async{
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn =
    await _firestoreInstance.collection("kids").get();
    setState(() {
      for(int i = 0; i<qn.docs.length; i++) {
        _products.add(
            {
              "name": qn.docs[i]["name"],
              "price": qn.docs[i]["price"],
              "image": qn.docs[i]["image"],
            }
        );
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                child: Text(
                  'Kids',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 1),
                  itemBuilder: (_,index){
                    return GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(_products[index]))),
                      child: Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            AspectRatio(aspectRatio: 1.5,child: Image.network(_products[index]["image"])),
                            Text("${_products[index]["name"]}",style: TextStyle(fontSize: 18),),
                            Text("BDT ${_products[index]["price"].toString()}"),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}