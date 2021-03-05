import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_care/showWorkouts.dart';

import 'HomePage.dart';

class exercises extends StatelessWidget{
  exercises({this.userID});
  String userID;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage(userID: userID);
                  }));
            },
          ),
          title: Text('My Exercises',
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15, bottom: 20),
          child: GridView.count(crossAxisCount: 2,
            childAspectRatio: .65,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Warm Up and Stretches', exerciseID: 'warmup_stretches');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Warm \nUp \nAnd \nStretchs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Ubuntu'
                    ),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Full Body Workouts', exerciseID: 'fullbody');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Full \nBody \nWorkouts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Ubuntu'
                    ),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Back and Trunk', exerciseID: 'back_trunk');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Back \nand \nTrunk',
                    textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                      fontFamily: 'Ubuntu'
                  ),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Upper Body', exerciseID: 'upperbody');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Upper \nBody',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Ubuntu'
                    ),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Lower Body', exerciseID: 'lowerbody');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Lower \nBody',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Ubuntu'
                    ),)),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return showWorkouts(userID: userID, name: 'Core Workouts',exerciseID: 'balance');
                      }));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Color(0xFFFEC0B2)]
                      )
                  ),
                  child: Center(child: Text('Balance \nWorkouts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        fontFamily: 'Ubuntu'
                    ),)),
                ),
              ),
            ],
          ),
        )

      )
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}