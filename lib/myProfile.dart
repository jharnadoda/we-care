import 'package:flutter/material.dart';
class myProfile extends StatelessWidget{
  final String email;
  myProfile({@required this.email});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('WeCare',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: SafeArea(
          child: Text(email),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}