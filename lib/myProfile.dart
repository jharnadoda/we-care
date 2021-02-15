import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/phone.dart';
final usersref= Firestore.instance.collection('users');
class myProfile extends StatefulWidget{
  final String userID;
  myProfile({@required this.userID});

  @override
  _myProfileState createState() => _myProfileState();
}

class _myProfileState extends State<myProfile> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController emailcontroller= TextEditingController();
  TextEditingController numbercontroller=TextEditingController();
  List<dynamic> users=[];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.done,
              color: Colors.black
              ),
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.account_circle,
                size: 100,),
                FutureBuilder<QuerySnapshot>(
                  future: usersref.where("id", isEqualTo: widget.userID).getDocuments(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.blueAccent,
                          ),
                        );
                      }
                      if(snapshot.hasData)
                        {
                          final userdata=snapshot.data.documents;
                          List<Column> userdatawidgets=[];
                          for(var dataitem in userdata){
                            final name= dataitem.data['displayName'];
                            namecontroller.text=dataitem.data['displayName'];
                            final namewidget= Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top:12),
                                  child: Text('Name',
                                  style: TextStyle(color: Colors.blueGrey),),
                                ),
                                TextField(
                                  controller: namecontroller,
                                  decoration: InputDecoration(
                                    hintText: 'Update Display Name',
                                  ),
                                )
                              ],
                            );
                            final email= dataitem.data['email'];
                            emailcontroller.text=dataitem.data['email'];
                            final emailwidget= Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top:12),
                                  child: Text('Email',
                                    style: TextStyle(color: Colors.blueGrey),),
                                ),
                                TextField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                    hintText: 'Update Email',
                                  ),
                                )
                              ],
                            );
                            final number= dataitem.data['number'];
                            numbercontroller.text=dataitem.data['number'];
                            final numberwidget= Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top:12),
                                  child: Text('Number',
                                    style: TextStyle(color: Colors.blueGrey),),
                                ),
                                TextField(
                                  controller: numbercontroller,
                                  decoration: InputDecoration(
                                    hintText: 'Update Contact Number',
                                  ),
                                )
                              ],
                            );
                            userdatawidgets.add(namewidget);
                            userdatawidgets.add(emailwidget);
                            userdatawidgets.add(numberwidget);
                          }
                          return Column(
                            children: userdatawidgets,
                          );
                        }
                    }
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  color: Color(0xFFFEC0B2),
                  onPressed: () {  },
                  child: Text('Update Profile'),
                ),
                RaisedButton(
                  child: Text("Logout"),
                  color: Color(0xFFFEC0B2),
                  onPressed: (){
                    googleSignIn.signOut();
                    print("signed out");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return phone();
                        }

                        ));
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
