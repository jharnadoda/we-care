import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_sms/flutter_sms.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

import 'elder_location.dart';

// The existing imports
// !! Keep your existing impots here !!

/// main is entry point of Flutter application
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) _setTargetPlatformForDesktop();
  return runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController _controllerPeople, _controllerMessage;
  ElderLocation elderLocation;
  String messageText = '';
  String _message, body;
  String _canSendSMSMessage = "Check is not run.";
  List <String> people=["9820446950"];


  @override
  void initState() {
    super.initState();
    initPlatformState();
    elderLocation = ElderLocation();

    getLocationDetails();
  }

  Future<void> initPlatformState() async {
    _controllerPeople = TextEditingController();
    _controllerMessage = TextEditingController();
  }

  void _sendSMS(List <String> recipents) async {
    try {
      String _result = await sendSMS(
          message: messageText, recipients: recipents);
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }
  getLocationDetails() async {//CALL THIS
    await elderLocation.getLocationData();
    messageText =
    'Hey , This is xyz find me at ${elderLocation.address} .\n Link to my location : ${elderLocation.url}';
    return elderLocation;
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: RaisedButton
            (
            child: Text('Emergency'),
            onPressed: (){
             // _send();
            },
          ),
        ),
      ),
    );

  }

  void _send() {
    if (people == null || people.isEmpty) {
      setState(() => _message = "At Least 1 Person or Message Required");
    } else {
      _sendSMS(people);
    }
  }
}