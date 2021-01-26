import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:we_care/AuthService.dart';
//import 'package:we_care/SignUpMember.dart';
import 'package:we_care/SplashScreen.dart';
import 'phone.dart';

import 'HomePage.dart';
//import 'SignUpVolunteer.dart';
void main ()
{
  runApp(WeCare());
}
class WeCare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      //home: AuthService().handleAuth(),
      //Scaffold(
      //   appBar: AppBar(
      //     title: Text('We Care'),
      //   ),
      //   body: Center(
      //     child: Container(
      //       child: Text('Home Page'),
      //     ),
      //   ),
      // ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        'phone': (context) => phone(),
        'HomePage': (context) => HomePage()
      },
    );
  }
}
