import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class volunteer_info extends StatelessWidget {
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
                  volunteer(),
                ],
              ),
            )));
  }
}
class volunteer extends StatefulWidget {
  @override
  _volunteerState createState() => _volunteerState();
}

class _volunteerState extends State<volunteer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 150.0, right: 5.0, bottom: 30.0),
          child: Text(
              'Welcome Volunteers',
            style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          ),
        ),
        SizedBox(height: 50,),
        Text('We wholeheartedly welcome you to this application and are so glad to see you take initiative in helping out the elderly. They have raised us and now it is our chance to protect them. ',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 20,),
        Text('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'),
        SizedBox(height: 20,),
        Text('Please fill the google form below to make it easier for us to connect you with the senior citizens. We will be requiring your Aadhar number for safety purposes.  ',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
        SizedBox(height: 30,),
      RaisedButton(
      onPressed: _launchURL,
        color: Color(0xFFFEC0B2),
        textColor: Colors.black,
        child: Text('Fill Form'),
          )

      ]),
    );
  }
  _launchURL() async {
    const url = 'https://docs.google.com/forms/d/e/1FAIpQLSdI-tZ4Deens2v20sFxY222g7Pc3il9Jzj5BAZjZUA9pQnstw/viewform?usp=sf_link';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
