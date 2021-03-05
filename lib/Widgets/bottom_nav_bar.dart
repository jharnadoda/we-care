import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_care/PillReminder.dart';
import 'package:we_care/constants.dart';
import 'package:we_care/myProfile.dart';
import 'package:we_care/volunteer_info.dart';
//import 'package:we_care/volunteer_info.dart';

class BottomNavBar extends StatelessWidget {
  //const BottomNavBar({
    //Key key,
  //}) : super(key: key);
  final String userID;
  BottomNavBar({@required this.userID});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: BottomNavItem(
              title: "Volunteer",
              svgScr: "assets/icons/calendar.svg",
            ),
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context){
                    return volunteer_info();
                  }
                  ));
            },
          ),
          BottomNavItem(
            title: "Home",
            svgScr: "assets/icons/gym.svg",
            isActive: true,
          ),
          GestureDetector(
            child: BottomNavItem(
              title: "Me",
              svgScr: "assets/icons/Settings.svg",
            ),
            onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return myProfile(userID: this.userID);
                    }
                    ));
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
