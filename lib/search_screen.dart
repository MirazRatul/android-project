import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/product_details_screen.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({Key? key}) : super(key: key);

  @override
  _Search_ScreenState createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  var inputText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: Text(
          'Search',
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0 ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Search products here',
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
                ),
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("products")
                        .where("genre", isEqualTo: inputText)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Something went wrong"),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("loading..."),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ProductDetails(data))),
                              title: Text(
                                data['name'],
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text("BDT ${data["price"].toString()}"),
                              leading: Image.network(data['image'],
                                  height: 200, width: 70),
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}