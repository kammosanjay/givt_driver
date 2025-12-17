import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';


class FirebaseMsg {
  final firebaseMsg = FirebaseMessaging.instance;
  

  Future<void> initFCM() async {
    var permission = await firebaseMsg.requestPermission();
    debugPrint('Permission : $permission');
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      throw Exception('User denied the Permission');
      
    }
    var token = await firebaseMsg.getToken();
    debugPrint("FirebaseToken :[   $token    ]  :  End");
    // for Background
    FirebaseMessaging.onBackgroundMessage(_handleNotification);

    // for foreground
    FirebaseMessaging.onMessage.listen(_handleNotification);

    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
  }

  static Future<void> _handleNotification(RemoteMessage msg) async {
    debugPrint('message received: ${msg.notification?.title}');
  }
}
