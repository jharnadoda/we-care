import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(signup_volunteer2());
}

class signup_volunteer2 extends StatelessWidget {
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
//Container(
                  //decoration: BoxDecoration(
                  // image: DecorationImage(image: AssetImage('images/WeCare.png'),
                  //),
                  //),
                  //),

                  signup_v2(),

                ],
              ),
            )

        )
    );
  }
}


class signup_v2 extends StatefulWidget {
  @override
  _signup_v2State createState() =>_signup_v2State();
}

class _signup_v2State extends State<signup_v2> {
  String gender="Male";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

        ),
//SizedBox(height: 30),

        SizedBox(height: 140),
/*CircleAvatar(
          radius: 50.0,
          backgroundImage: AssetImage('images/volunteer1.jpg'),
        ),*/
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
          child: Row(
            children: [
              Text(
                'Almost there',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 100),

        Padding(
          padding:
          const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
          child: TextField(

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(Icons.home),
              labelText: 'Enter Address ',
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
              prefixIcon: Icon(Icons.calendar_today),
              labelText: 'DOB (ddmmyyyy) ',
              fillColor: Colors.teal[100],
            ),
          ),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
          child: Row(
            children: [
              Icon(Icons.person),

              Text(
                'Choose Gender:',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 20.0,

                  color: Colors.black,
                ),
              ),

              SizedBox(width: 10),
              DropdownButton<String>(
                  hint: Text('Choose Gender'),
//icon: Icon(Icons.perm_identity),
                  value: gender,
                  items: [
                    DropdownMenuItem(
                      child: Text('Male'),
                      value: 'Male',
                    ),
                    DropdownMenuItem(
                      child: Text('Female'),
                      value: 'Female',
                    ),
                    DropdownMenuItem(
                      child: Text('Others'),
                      value: 'Others',
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value;
                    });
                  }),
            ],
          ),
        ),
        SizedBox(height: 30),
        RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return login();
            }));
          },
          color: Color(0xFFFEC0B2),
          textColor: Colors.black,
          child: Text('Signup'),

        )

      ],
    );
  }
}
