import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:we_care/chatList.dart';
class createUsername extends StatelessWidget{
  String userID;
  createUsername({@required this.userID});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 150),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
                      child: Text(
                        'To join Chatrooms \n and find Friends \n Create a Username',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],

                ),
                screenBody(userID: this.userID),
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
class screenBody extends StatelessWidget{
  String userID;
  TextEditingController username= TextEditingController();
  screenBody({@required this.userID});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        IconButton(
          icon: Icon(Icons.volume_up),
          //tooltip: 'Increase volume by 10',
          onPressed: () {

          },
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding:EdgeInsets.only(left: 10.0, right: 10.0),
          child: TextField(
            controller: username,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(Icons.account_circle),
              labelText: 'Create a Username',
              fillColor: Colors.teal[200],
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 30,
            ),
            RaisedButton(
              child: Text('Create Username'),
              color: Color(0xFFFEC0B2),
              onPressed: (){
                Firestore.instance.collection('users').document(this.userID)
                    .updateData({
                  'username': username.text
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return chatList(userID: this.userID);
                    }));
              },
            )
          ],
        ),
        SizedBox(
          height: 200,
        )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
