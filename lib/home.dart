import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:homesafety_app/main.dart';
import 'package:provider/provider.dart';
import 'package:homesafety_app/mqtt/state/MQTTAppState.dart';
import 'package:homesafety_app/mqtt/MQTTManager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {

  MQTTAppState currentAppState;
  MQTTManager manager;

  bool roomOneFlag;

  void linkop (work) async{
    if (await canLaunch(work)){
      await launch(work);
    }
    else{
      print('Whoops!');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MQTTAppState appState = Provider.of<MQTTAppState>(context);
    //reference to app state
    currentAppState = appState;
    roomOneFlag = (currentAppState.getReceivedText) == "true" ? true: false;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[700],
        ),
        elevation: 24,
        title: Text(
          "Home Safety",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Wind',
            color: Colors.grey[700],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFAF3DD),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffffc226),
              Color(0xfffce986),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children:[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      color: Colors.deepOrangeAccent,
                      child: Text(
                          _prepareStateMessageFrom(currentAppState.getAppConnectionState),
                          textAlign: TextAlign.center
                      )
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children:[
                    MaterialButton(
                      padding: EdgeInsets.fromLTRB(20.0,15.0,20.0,10.0),
                      color: currentAppState.getAppConnectionState == MQTTAppConnectionState.connected
                          ? (roomOneFlag == false ? Colors.red[900] : Colors.green[900]) : Colors.grey[700],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      onPressed: (){
                        print("Current topic: "+currentTopic);
                        currentAppState.getAppConnectionState == MQTTAppConnectionState.disconnected
                          ? _configureAndConnect()
                          : _disconnect();
                      },
                      child: SizedBox(
                        height: 120.0,
                        width: 360.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Living Room",
                              style: TextStyle(
                                fontFamily: 'MateSC',
                                fontSize: 28.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]
                ),
              )
          ),
          ]
        ),
      ),
      drawer: Container(
        width: 150,
        padding: EdgeInsets.fromLTRB(10, 42, 10, 36),
        alignment: Alignment.topCenter,
        color: Colors.grey[600],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.person_pin_rounded,
                    size: 108,
                    color: Colors.white,
                  ),
                  radius: 56,
                  backgroundColor: Color(0x00000000),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 170,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Colors.white,
                          // fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 10,),
                      Text(
                        currentName,
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Nexa',
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(
                        height: 40,
                        thickness: 1,
                        color: Colors.white,
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                OutlineButton(
                  onPressed: (){
                    linkop('mailto:theritwikkundu@gmail.com');
                  },
                  child: SizedBox(
                    width: 140,
                    child: Text(
                      "FEEDBACK",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nexa',
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                    clearAll();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: SizedBox(
                    width: 140,
                    child: Text(
                      "LOGOUT",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Nexa',
                          color: Colors.black87,
                          fontWeight: FontWeight.w600
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawerScrimColor: Color(0x55FAF3DD),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        alignment: Alignment.topLeft,
        child: FloatingActionButton(
          elevation: 100,
          onPressed: (){
            return showDialog(context: context, barrierDismissible: false, builder: (context){
              return AlertDialog(
                title: Text(
                  "About the app",
                  textAlign: TextAlign.center,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'Nexa',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                content: SingleChildScrollView(
                  child: Text(
                    "The main objective of our project is to create a comprehensive real-time system for home safety. \nThe primary concern of home security is unauthorized intrusion.\n Our Home Safety app aims to assist the users in tracking any movement in their homes through a reliable MQTT connection in a hassle-free manner.\n\nTeam:\nRitwik Kundu (19BCE0547)\nDebangsu Sarkar (19BCE0902)",
                    style: TextStyle(
                      fontFamily: 'Nexa',
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                actions: [
                  MaterialButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Nexa',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    splashColor: Color(0xff4A7C59),
                  )
                ],
                backgroundColor: Color(0xfffce986),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              );
            });
          },
          backgroundColor: Color(0x004A7C59),
          child: Icon(
            Icons.info_sharp,
            size: 60,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }

  // utility functions
  String _prepareStateMessageFrom(MQTTAppConnectionState state) {
    switch (state) {
      case MQTTAppConnectionState.connected:
        return 'Connected';
      case MQTTAppConnectionState.connecting:
        return 'Connecting';
      case MQTTAppConnectionState.disconnected:
        return 'Disconnected';
    }
  }

  void _configureAndConnect() {
    String osPrefix = 'Flutter_Android';

    manager = MQTTManager(
        host: "broker.hivemq.com",   //HostID
        topic: currentTopic,   //TopicID
        identifier: osPrefix,
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }

  void _disconnect(){
    manager.disconnect();
  }
}