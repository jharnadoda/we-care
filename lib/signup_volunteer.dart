import 'package:flutter/material.dart';
import 'signup_volunteer2.dart';

void main() {
  runApp(signup_volunteer());
}

class signup_volunteer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
//backgroundColor: Colors.teal[100],
        /*appBar: AppBar(
          backgroundColor: Colors.teal[300],
          title: Text('WeCare'),
          centerTitle: true,
        ),*/
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              signup_v(),
            ],
          ),
        ),
      ),
    );
  }
}

class signup_v extends StatefulWidget {
  @override
  _signup_vState createState() =>_signup_vState();
}

class _signup_vState extends State<signup_v> {
//String gender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(),
      SizedBox(height: 130),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
            child: Text(
              'Hi Buddy,\nLet\'s sign you up',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 100),
      Padding(
        padding:
        const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
              borderRadius: new BorderRadius.circular(10.0),
            ),
            prefixIcon: Icon(Icons.perm_identity),
            labelText: 'Enter name',
            fillColor: Colors.teal[200],
          ),
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding:
        const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            prefixIcon: Icon(Icons.mail_outline),
            labelText: 'Enter Email ',
            fillColor: Colors.teal[100],
          ),
        ),
      ),
      SizedBox(height: 10),
      Padding(
        padding:
        const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            prefixIcon: Icon(Icons.vpn_key),
            labelText: 'Enter Password ',
            fillColor: Colors.teal[100],
          ),
        ),
      ),
//SizedBox(height: 10),

      SizedBox(height: 30),
      RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return signup_volunteer2();
          }));
        },
        color: Color(0xFFFEC0B2),
        textColor: Colors.black,
        child: Text('Next'),
      )
    ]);
  }
}
