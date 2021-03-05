import 'package:we_care/addBloodSugar.dart';
import 'package:we_care/bloodSugarTrackerScreen.dart';
import 'HomePage.dart';
import 'addBloodPressure.dart';
import 'bloodPressureTrackerScreen.dart';
import 'addWeight.dart';
import 'weightTrackerScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TrackerHome extends StatefulWidget {
  @override
  TrackerHome({this.userID});
  String userID;
  _TrackerHomeState createState() => _TrackerHomeState();
}

class _TrackerHomeState extends State<TrackerHome> {
  Map<String, bool> hideMap, trackMap;
  initializeDisplayMap() {
    hideMap = Map<String, bool>();
    trackMap = Map<String, bool>();
    hideMap = {'weight': true, 'sugar': true, 'pressure': true};
    trackMap = {'weight': true, 'sugar': true, 'pressure': true};
  }

  onHide(String type) {
    setState(() {
      hideMap[type] = false;
    });
  }

  @override
  void initState() {
    initializeDisplayMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
            color: Colors.black,),
          onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return HomePage(userID: widget.userID);
                }));
          },
        ),
        title: Text('Health Vitals Trackers',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFEC0B2),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TrackerCard(
            title: 'Weight Tracker',
            subTitle: '\nAdd your Weight!\n',
            onAdd: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddWeightScreen();
              }));
            },
            onHide: () => onHide('weight'),
            onView: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return WeightTrackerScreen();
              }));
            },
            isHidden: hideMap['weight'],
            isTracking: trackMap['weight'],
          ),
          TrackerCard(
            title: 'Blood Pressure',
            subTitle: '\nAdd your BP reading today!\n',
            onAdd: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddBloodPressureScreen();
              }));
            },
            onHide: () => onHide('pressure'),
            onView: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BloodPressureTrackerScreen();
              }));
            },
            isHidden: hideMap['pressure'],
            isTracking: trackMap['pressure'],
          ),
          TrackerCard(
            title: 'Blood Sugar',
            subTitle: '\nAdd your Blood Sugar reading today!\n',
            onAdd: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return AddBloodSugarScreen();
              }));
            },
            onHide: () => onHide('sugar'),
            onView: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return BloodSugarTrackerScreen();
              }));
            },
            isHidden: hideMap['sugar'],
            isTracking: trackMap['sugar'],
          ),
        ],
      ),
    );
  }
}

class TrackerCard extends StatelessWidget {
  final String title, subTitle;
  final onHide, onAdd, onView;
  final bool isTracking, isHidden;
  TrackerCard(
      {this.title,
      this.isHidden,
      this.onAdd,
      this.onHide,
      this.subTitle,
      this.onView,
      this.isTracking});
  @override
  Widget build(BuildContext context) {
    if (isHidden) {
      return Card(
        elevation: 2,
        color: Colors.grey.shade50,
        margin: EdgeInsets.all(18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 3.3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.poll,
                        color: Color(0xFFffc0b4),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w100, fontSize: 22),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  subTitle,
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  isTracking
                      ? RaisedButton(
                          onPressed: onView,
                          elevation: 2,
                          textColor: Color(0xFFffc0b4),
                          child: Text(
                            'View Chart',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color(0xFFffc0b4),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                        )
                      : RaisedButton(
                          onPressed: onHide,
                          elevation: 2,
                          textColor: Color(0xFFffc0b4),
                          child: Text(
                            'Hide',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Color(0xFFffc0b4),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                        ),
                  SizedBox(
                    width: 25,
                  ),
                  RaisedButton(
                      color: Color(0xFFffc0b4),
                      elevation: 2,
                      textColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Add data',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: onAdd),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }
}
