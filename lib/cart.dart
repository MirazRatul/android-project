import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'checkout.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  double total = 0;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
        // actions: [
        //   IconButton(icon: Icon(Icons.done,color: Colors.black,),
        //     onPressed: (){
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => const CheckOut()));
        //     },
        //   )
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-cart-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection("items")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Something is wrong"),
                  );
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];

                      return Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Image.network(
                            _documentSnapshot["image"],
                          ),
                          title: Center(
                              child: Text(
                                _documentSnapshot["name"],
                                style: TextStyle(fontSize: 22),
                              )),
                          subtitle: Center(
                            child: Text(
                              "BDT  ${_documentSnapshot["price"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 18),
                            ),
                          ),
                          trailing: GestureDetector(
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.orange.shade200,
                            ),
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("users-cart-items")
                                  .doc(FirebaseAuth
                                  .instance.currentUser!.email)
                                  .collection("items")
                                  .doc(_documentSnapshot.id)
                                  .delete();
                              FirebaseFirestore.instance
                                  .collection("users-order")
                                  .doc(FirebaseAuth
                                  .instance.currentUser!.email)
                                  .collection("items")
                                  .doc(_documentSnapshot.id)
                                  .delete();
                            },
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: 270,
                decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total Price - BDT ',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    Container(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users-cart-items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .snapshots(),
                        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            total = 0;
                            snapshot.data!.docs.forEach((result) {
                              total += result["price"];
                            });
                            return Text(total.toString(),
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
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

                FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("items").get().then((snapshot) {
                  for (DocumentSnapshot ds in snapshot.docs) {
                    ds.reference.delete();
                  }
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CheckOut()));
              },
              child: Text("Checkout",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 15,)
        ],
      ),);
  }
}

