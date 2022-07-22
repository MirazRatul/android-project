import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:retrive_data/services/local_notifications.dart';

class Notification_Page extends StatefulWidget {
  const Notification_Page({Key? key}) : super(key: key);

  @override
  _Notification_PageState createState() => _Notification_PageState();
}

class _Notification_PageState extends State<Notification_Page> {

  String notificationMsg = "Waiting for notifications ";
  @override
  void initState(){
    super.initState();

    LocalNotificationService.initilize();

    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null){
        setState(() {
          notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from terminated state";
        });
      }
    });
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      setState(() {
        notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from foreground";
      });
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      setState(() {
        notificationMsg = "${event.notification!.title} ${event.notification!.body} I am coming from background";
      });
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Text(
            notificationMsg,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

