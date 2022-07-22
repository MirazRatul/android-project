import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class Phone_Call extends StatefulWidget {
  const Phone_Call({Key? key}) : super(key: key);

  @override
  _Phone_CallState createState() => _Phone_CallState();
}

class _Phone_CallState extends State<Phone_Call> {

  final number1 = '01793594055';
  final number2 = '01937153621';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Help_Center1',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(
                    width: 220,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text(
                          'call',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                        ),
                    onPressed: () async{
                         launch('tel://$number1');
                         await FlutterPhoneDirectCaller.callNumber(number1);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Help_Center2',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
              SizedBox(
                width: 220,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(15),
                ),
                child: Text(
                  'call',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                onPressed: () async{
                  launch('tel://$number2');
                  await FlutterPhoneDirectCaller.callNumber(number2);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
