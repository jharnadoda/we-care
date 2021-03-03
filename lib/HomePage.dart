//import 'dart:html';
import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_care/HealthVitals.dart';
//import 'package:we_care/chatScreen.dart';
//import 'package:we_care/LoginPage.dart';
import 'package:we_care/constants.dart';
import 'package:we_care/phone.dart';
import 'package:we_care/screens/details_screen.dart';
import 'package:we_care/Widgets/bottom_nav_bar.dart';
import 'package:we_care/Widgets/search_bar.dart';
import 'package:we_care/PillReminder.dart';
import 'NearbyHospitalScreen.dart';
import 'NearbyPharmacyScreen.dart';
import 'NearbyPoliceScreen.dart';
import 'Widgets/CustomBox.dart';
import 'models/users.dart';
import 'trackerHome.dart';

import 'elder_location.dart';
import 'package:flutter_sms/flutter_sms.dart';

final usersRef = Firestore.instance.collection('users');

class HomePage extends StatefulWidget {
  HomePage({@required this.userID});
  String userID;
  // This widget is the root of your application.
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Care',
      theme: ThemeData(
        fontFamily: "Cookie",
        scaffoldBackgroundColor: Colors.teal[450],
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: HomeScreen(userID: widget.userID),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({@required this.userID});
  String userID;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(userID: widget.userID),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Color(0xFFffc0b4),
              // image: DecorationImage(
              //alignment: Alignment.centerLeft,
              //image: AssetImage("images/bg1.png"),
              //),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFffc0b7),
                        shape: BoxShape.circle,
                      ),
                      child: RaisedButton(
                        onPressed: (){
                          _send();
                       //    Navigator.push(
                       //        context,
                       //        MaterialPageRoute(builder: (context) {
                       //      return MyApp();
                       // }
                       // ),
                       // );
                        }
                      )
                    ),
                  ),
                  FutureBuilder<DocumentSnapshot>(
                      future: usersRef.document(widget.userID).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        Map<String, dynamic> data = snapshot.data.data;
                        String name = data['displayName'];
                        return Text(
                          "Good Morning $name",
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w900),
                        );
                      }),
                  SearchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        //tooltip: 'Increase volume by 10',
                        onPressed: () {
                          final player = AudioCache();
                          player.play("menu.mp3");
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        CustomBox(
                          title: "My Buddy",
                          img: "images/volunteer1.jpg",
                          press: () {},
                        ),
                        CustomBox(
                          title: "My Pills",
                          img: "images/medsIcon.png",
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return pill(userID: widget.userID);
                            }));
                          },
                        ),
                        CustomBox(
                          title: "My Vitals",
                          img: "images/sugarIcon.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return TrackerHome();
                              }),
                            );
                          },
                        ),
                        CustomBox(
                          title: "Pharmacies Near Me",
                          img: "images/pharmacy.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return NearbyPharmacyScreen();
                              }),
                            );
                          },
                        ),
                        CustomBox(
                          title: "Hospitals Near Me",
                          img: "images/hospital.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return NearbyHospitalScreen();
                              }),
                            );
                          },
                        ),
                        CustomBox(
                          title: "Police Stations Near Me",
                          img: "images/ps.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return NearbyPoliceScreen();
                              }),
                            );
                          },
                        ),
                        CustomBox(
                          title: "My Chats",
                          img: "images/phone.png",
                          press: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              //return chatScreen(userID: widget.userID);
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  ElderLocation elderLocation;
  String messageText = '';
  String _message, body;
  String _canSendSMSMessage = "Check is not run.";
  List <String> people=["9820446950"];

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    elderLocation = ElderLocation();

    getLocationDetails();
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
  void _send() {
    if (people == null || people.isEmpty) {
      setState(() => _message = "At Least 1 Person or Message Required");
    } else {
      _sendSMS(people);
    }
  }
}

