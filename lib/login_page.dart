import 'package:flutter/material.dart';
import 'phone.dart';

class login extends StatelessWidget {
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
                  login2(),
                ],
              ),
            )));
  }
}

class login2 extends StatefulWidget {
  @override
  _login2State createState() =>_login2State();
}

class _login2State extends State<login2> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(),
      //SizedBox(height: 30),
      //SizedBox(height: 20),
//CircleAvatar(
      //radius: 50.0,
      // backgroundImage: AssetImage('images/old2.jpg'),
      //),
      SizedBox(height: 90),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 15, top: 0.0, right: 15.0, bottom: 0.0),
            child: Text(
              'Hi there,',
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 100),

      Padding(
          padding: const EdgeInsets.only(
              left: 15, top: 0.0, right: 15.0, bottom: 0.0),
          child: Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.phone),
                labelText: 'Enter Phone Number ',
                fillColor: Colors.white,
              ),
            ),
/*decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(255, 187, 187, 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              ),*/
          )),

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
      SizedBox(height: 10),
      Center(
          child: Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.black),
          )),

      SizedBox(height: 20),
      Container(
/*decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20)
          */ /*boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            //Color.fromRGBO(255, 187, 187, 1.0),
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
*/ /*

        ),*/

        child: RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
//return signup_volunteer();
            }));
          },
          color: Color(0xFFFEC0B2),
          textColor: Colors.black,
          child: Text('Login'),
        ),
      ),
      SizedBox(height: 20),

      Text(
        'Dont have an account? Click below',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      RaisedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return phone();
          }));
        },
        color: Color(0xFFFEC0B2),
        textColor: Colors.black,
        child: Text('Signup'),
      ),
    ]);
  }
}
