//import 'dart:html';
import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_care/HealthVitals.dart';
//import 'package:we_care/LoginPage.dart';
import 'package:we_care/constants.dart';
import 'package:we_care/phone.dart';
import 'package:we_care/screens/details_screen.dart';
import 'package:we_care/Widgets/bottom_nav_bar.dart';
import 'package:we_care/Widgets/search_bar.dart';
import 'package:we_care/PillReminder.dart';
import 'Widgets/CustomBox.dart';
import 'models/users.dart';
class HomePage extends StatefulWidget {
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  String name, mail;
  getCurrentUser() async
  {
    GoogleSignInAccount user= googleSignIn.currentUser;
    mail=user.email;
    final QuerySnapshot snapshot= await usersRef.where("email", isEqualTo: mail).getDocuments();
    snapshot.documents.forEach((DocumentSnapshot doc) {
      setState(() {
        name=User.fromDocument(doc).displayName;
      });
    });
  }

  Widget build(BuildContext context) {
    getCurrentUser();
        var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(email:mail),
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
                      child: Image.asset(
                        'images/emergency.png',
                        width: 70,
                        height: 70,
                      ),
                    ),
                  ),
                  Text(
                    "Good Morning $name",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SearchBar(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        //tooltip: 'Increase volume by 10',
                        onPressed: () {
                          final player= AudioCache();
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
                                MaterialPageRoute(builder: (context){
                                  return pill(email: mail);
                                }
                                ));
                          },
                        ),
                        CustomBox(
                          title: "My Health",
                          img: "images/myHealth.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return HealthVitals();
                              }),
                            );
                          },
                        ),
                        CustomBox(
                          title: "Hospitals Near Me",
                          img: "images/hospital.JPG",
                          press: () {

                          },
                        ),
                        RaisedButton(
                          child: Text("Logout"),
                          onPressed: (){
                            googleSignIn.signOut();
                            print("signed out");
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return phone();
                                }

                                ));
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
}
