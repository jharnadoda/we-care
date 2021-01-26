import 'package:flutter/material.dart';
import 'signup_volunteer.dart';

void main()
{
  runApp(otp());
}

class otp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
//backgroundColor: Colors.teal[100],

            body:Container(
              decoration:  BoxDecoration(
                image:  DecorationImage(image: AssetImage('images/bg2.png'),
                  fit:BoxFit.cover,
                ),
              ),
              child: Column(
                children: [


                  otp_2(),

                ],
              ),
            )

        )
    );
  }
}
class otp_2 extends StatefulWidget {
  @override
  _otp_2State createState() =>_otp_2State();
}

class _otp_2State extends State<otp_2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 140),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
          child: Row(
            children: [
              Center(
                child: Text(
                  'Verification \nCode',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),


        SizedBox(height: 50),
        Center(
          child: Text(
            'Please enter code sent to your phone',
            style: TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 40),

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
              labelText: 'Enter OTP',

            ),
          ),
        ),

        SizedBox(height: 50),
        RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return signup_volunteer();
            }));
          },
          color: Color(0xFFFEC0B2),
          textColor: Colors.black,
          child: Text('Submit'),

        )

      ],
    );
  }
}
