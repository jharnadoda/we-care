//import 'dart:html';
import 'package:audioplayers/audio_cache.dart';
import 'package:we_care/police.dart';
//import 'package:we_care/Widgets/app_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:we_care/HomePage.dart';

LocationManager.Location location = LocationManager.Location();

class NearbyPoliceScreen extends StatefulWidget {
  static const String id = 'Nearby_Police_screen';
  @override
  State<StatefulWidget> createState() {
    return NearbyPoliceScreenState();
  }
}

class NearbyPoliceScreenState extends State<NearbyPoliceScreen> {
  bool showSpinner = true;
  HospitalData hospitalData;
  @override
  initState() {
    super.initState();
    hospitalData = HospitalData();
    hospitalData.getNearbyHospital();
  }

  double lat, tempLon;
  String locationUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: AppDrawer(),
      // appBar: ElderlyAppBar(),
      body: FutureBuilder(
        future: hospitalData.getNearbyHospital(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitPouringHourglass(
                    color: Colors.pinkAccent,
                    size: 100.0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Searching for police stations nearby..'),
                  ),
                  Text(' Please wait! '),
                ],
              ),
            );
          } else {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Police Station Near You',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.volume_up),
                  //tooltip: 'Increase volume by 10',
                  onPressed: () {
                    final player = AudioCache();
                    player.play('chemists.mp3');
                  },
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: snapshot.data.hospitalList.length,
                      itemBuilder: (context, index) {
                        if (index % 2 == 0) {
                          var hosLon = snapshot.data.hospitalList[index]
                              .hospitalLocationLongitude
                              .toString();
                          var hosLat = snapshot
                              .data.hospitalList[index].hospitalLocationLatitude
                              .toString();

                          return Column(
                            children: <Widget>[
                              Card(
                                margin: EdgeInsets.all(15),
                                color: Colors.lightBlueAccent,
                                elevation: 2.5,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Icon(Icons.local_hospital,
                                        size: 40, color: Colors.red),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(snapshot
                                            .data
                                            .hospitalList[index]
                                            .hospitalDistance
                                            .toString() +
                                        ' kms'),
                                  ),
                                  title: snapshot.data.hospitalList[index]
                                              .hospitalName !=
                                          null
                                      ? Text(
                                          snapshot.data.hospitalList[index]
                                              .hospitalName,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        )
                                      : Text(''),
                                  onTap: () {
                                    launch(
                                        'https://www.google.com/maps/dir/${snapshot.data.userLocation.latitude},${snapshot.data.userLocation.longitude}/$hosLat,$hosLon');
                                  },
                                ),
                              )
                            ],
                          );
                        } else
                          return SizedBox();
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
