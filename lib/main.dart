import 'package:flutter/material.dart';
import 'package:homesafety_app/home.dart';
import 'package:homesafety_app/login.dart';
import 'package:homesafety_app/register.dart';
import 'package:provider/provider.dart';
import 'mqtt/state/MQTTAppState.dart';

// global variables
String currentPh="default phone";
String currentName="default name";
String currentPass="default pass";
String currentDob="default dob";
String currentTopic="default topic";

void clearAll(){
  currentPh="default phone";
  currentName="default name";
  currentPass="default pass";
  currentDob="default dob";
  currentTopic="default topic";
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginP(),
      '/register': (context) => RegisterP(),
      '/home': (context) =>
          ChangeNotifierProvider<MQTTAppState>(
            create: (_) => MQTTAppState(),
            child: HomeP(),
          ),
    },
  ));
}