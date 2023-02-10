import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp();
final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseMessaging messaging = FirebaseMessaging.instance;
String api =
    "https://api.openweathermap.org/data/2.5/weather?q=Ramallah&mode=json&appid=99b40779b5288bb0b5c817abaf4356be";
//99b40779b5288bb0b5c817abaf4356be
