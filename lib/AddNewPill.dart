import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:we_care/HomePage.dart';
import 'package:we_care/screens/details_screen.dart';

import 'models/users.dart';
final pillref= Firestore.instance.collection('pills');
class AddNewPill extends StatefulWidget {
  final String email;
  AddNewPill({@required this.email});
    @override
  _AddNewPillState createState() => _AddNewPillState();
}

class _AddNewPillState extends State<AddNewPill> {
  String medicineType;
  @override
  final _nameController=TextEditingController();
  final _timeController=TextEditingController();
  final _quantiyController=TextEditingController();
  final _unitController=TextEditingController();


  Widget build(BuildContext context) {
    // TODO: implement build
    {
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
                  Center(
                    child: Text(
                      'Add a New Pill',
                      style: TextStyle(
                        color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage("images/medsIcon.png"),
                    width: 175,
                    height: 175,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.prescriptionBottleAlt),
                        labelText: 'Pill Name',
                        fillColor: Colors.teal[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: _timeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.clock),
                        labelText: 'Time',
                        fillColor: Colors.teal[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 13,
                          ),
                          Icon(
                            FontAwesomeIcons.pills,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: DropdownButtonFormField(
                              hint: Text('Choose Medicine Type'),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                                )
                              ),
                              value: medicineType,
                              items: [
                                DropdownMenuItem(
                                  child: Text('Tablet'),
                                  value: 'Tablet',
                                ),
                                DropdownMenuItem(
                                  child: Text('Capsule'),
                                  value: 'Capsule',
                                ),
                                DropdownMenuItem(
                                  child: Text('Syrup'),
                                  value: 'Syrup',
                                ),
                                DropdownMenuItem(
                                  child: Text('Others'),
                                  value: 'Others',
                                )
                              ],
                                onChanged: (value) {
                                  setState(() {
                                    medicineType = value;
                                  });
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: _quantiyController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.prescriptionBottle),
                        labelText: 'Quantity',
                        fillColor: Colors.teal[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TextField(
                      controller: _unitController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        prefixIcon: Icon(FontAwesomeIcons.weight),
                        labelText: 'Unit',
                        fillColor: Colors.teal[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    color: Color(0xFFFEC0B2),
                    child: Text("Add"),
                    onPressed: (){
                      print(_nameController.text.trim());
                      print(_timeController.text.trim());
                      print(medicineType);
                      print(_quantiyController.text.trim());
                      print(_unitController.text.trim());
                      print(widget.email);
                      pillref.add({"Email": widget.email,
                        "PillName": _nameController.text.trim(),
                      "Time": _timeController.text.trim(),
                      "MedicineType": medicineType,
                      "Quantity": _quantiyController.text.trim(),
                      "Unit": _unitController.text.trim()},
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
    throw UnimplementedError();
  }
}