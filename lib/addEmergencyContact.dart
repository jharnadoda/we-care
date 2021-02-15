import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class addEmergencyContact extends StatelessWidget {
  String userID;
  addEmergencyContact({@required this.userID});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              screenBody(userID: this.userID),
            ],
          ),
        ),
      ),
    );
  }
}

class screenBody extends StatelessWidget{
  String userID;
  TextEditingController number= TextEditingController();
  screenBody({@required this.userID});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        SizedBox(height: 130),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
              child: Text(
                'Let your loved ones \nknow about you',
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
        SizedBox(
          height: 20,
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          //tooltip: 'Increase volume by 10',
          onPressed: () {

          },
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding:EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
            controller: number,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(Icons.phone),
              labelText: 'Add an Emergency Contact',
              fillColor: Colors.teal[200],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('Skip'),
              color: Color(0xFFFEC0B2),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage(userID:this.userID);
                }));
              },
            ),
            SizedBox(
              width: 30,
            ),
            RaisedButton(
              child: Text('Continue'),
              color: Color(0xFFFEC0B2),
              onPressed: (){
                String tempNum= number.text;
                Firestore.instance.collection('users').document(this.userID)
                    .updateData({
                  'emergencyContact': '+91 $tempNum'
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage(userID:this.userID);
                }));
              },
            )
          ],
        )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}