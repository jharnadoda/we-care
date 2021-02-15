import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
final pillref= Firestore.instance.collection('pills');
class displayPills extends StatefulWidget{
  final String userID;
  displayPills({@required this.userID});
  @override
  _displayPillsState createState() => _displayPillsState();
}

class _displayPillsState extends State<displayPills> {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('WeCare',
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text("My Pills",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                FutureBuilder<QuerySnapshot>(
                  future: pillref.where("id", isEqualTo: widget.userID).getDocuments(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData)
                    {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    }
                      {
                        final pillData= snapshot.data.documents;
                        List<pillTile> pillDataWidgets=[];
                        for(var pill in pillData){
                          final pillName=pill.data['PillName'];
                          final time=pill.data['Time'];
                          final quantity=pill.data['Quantity'];
                          final unit=pill.data['Unit'];
                          final medicineType=pill.data['MedicineType'];
                          final pillWidget= pillTile(pillName: pillName, time: time, quantity: quantity, unit: unit, medicineType: medicineType);
                          pillDataWidgets.add(pillWidget);
                        }
                        return Column (
                          children: pillDataWidgets,
                        );
                      }
                        }
                )
              ],
            ),
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
class pillTile extends StatelessWidget{
  pillTile({this.pillName, this.time, this.quantity, this. unit, this.medicineType});
  final String pillName, time, quantity, unit, medicineType;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFFEC0B2),
            border: Border.all(color: Colors.black,
                width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(pillName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('$quantity $unit',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Medicine Type: $medicineType',
                    style: TextStyle(
                      fontSize: 15
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
  
}