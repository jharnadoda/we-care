import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_care/constants.dart';
import 'package:we_care/screens/details_screen.dart';
import 'package:we_care/Widgets/bottom_nav_bar.dart';

import 'package:we_care/Widgets/search_bar.dart';
import 'SplashScreen.dart';

import 'Widgets/CustomBox.dart';

class HealthVitals extends StatelessWidget {
  // This widget is the root of your application.
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
      home: HealthV(),
    );
  }
}

class HealthV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
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
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFffc0b7),
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'images/emergency.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                  Text(
                    "Health Vitals",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 50),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .55,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: <Widget>[
                        CustomBox(
                          title: "My Sugar",
                          img: "images/sugarIcon.jpg",
                          press: () {},
                        ),
                        CustomBox(
                          title: "My BP",
                          img: "images/bpIcon.png",
                          press: () {},
                        ),
                        // CustomBox(
                        //   title: "My BP",
                        //   img: "images/old1.jpg",
                        //   press: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) {
                        //         return DetailsScreen();
                        //       }),
                        //     );
                        //   },
                        // ),
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
