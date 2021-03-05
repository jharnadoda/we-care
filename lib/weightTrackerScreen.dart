import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:we_care/models/tracker.dart';
import 'package:we_care/Widgets/chartWeight.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_care/trackerHome.dart';

class WeightTrackerScreen extends StatefulWidget {
  WeightTrackerScreen({this.userID});
  String userID;
  @override
  _WeightTrackerScreenState createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  getCurrentUser() async {
    await FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        userId = user.uid;
      });
    });
  }

  QuerySnapshot snapshot;
  String userId;
  double averageWeight;
  WeightTracker weightTracker;

  getDocumentList() async {
    weightTracker = WeightTracker();
    snapshot = await Firestore.instance
        .collection('tracker')
        .document(userId)
        .collection('weight')
        .getDocuments();
    averageWeight = 0;
    double totalWeight = 0;

    List<Weight> list = weightTracker.loadData(snapshot);
    for (var s in list) {
      totalWeight += s.weight;
    }
    setState(() {
      averageWeight = totalWeight / list.length;
    });

    return snapshot;
  }

  @override
  void initState() {
    getCurrentUser();
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
                  return TrackerHome(userID: widget.userID);
                }));
          },
        ),
        title: Text('WeCare',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFFEC0B2),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Text(
                'Weight Tracker',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFFffc0b4),
                ),
              ),
            ),
          ),
          FutureBuilder(
              future: getDocumentList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.all(15),
                          constraints: BoxConstraints(
                            //minWidth: MediaQuery.of(context).size.width ,
                            maxHeight: MediaQuery.of(context).size.height / 1.7,
                            maxWidth: MediaQuery.of(context).size.width *
                                (snapshot.data.documents.length / 3),
                          ),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: WeightChart(
                                animate: true,
                                userID: userId,
                              ),
                            ),
                            margin: EdgeInsets.all(8),
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: ListTile(
                          subtitle: Text('Average Weight'),
                          title: Text(averageWeight.toStringAsFixed(2)),
                        ),
                      )
                    ],
                  );
                } else
                  return SizedBox();
              }),
        ],
      ),
    );
  }
}
