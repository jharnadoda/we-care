import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:we_care/LoginPage.dart';
//import 'package:we_care/SignUpMember.dart';
import 'package:we_care/main.dart';
import 'package:we_care/HomePage.dart';
import 'package:we_care/phone.dart';
//import 'package:we_care/phone_verif.dart';

import 'HealthVitals.dart';
import 'HomePage.dart';

//import 'SignUpVolunteer.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      // child: Center(
      //   child: Text(
      //     'We Care',
      //     style: TextStyle(
      //       fontFamily: 'Cookie',
      //       fontSize: 50.0,
      //     ),
      //   ),
      // ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/SSbg.png'), fit: BoxFit.cover)));
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => phone()));
  }
}
