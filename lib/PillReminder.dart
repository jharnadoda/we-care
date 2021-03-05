import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/AddNewPill.dart';
import 'HomePage.dart';
import 'displayPills.dart';
class pill extends StatelessWidget{
  final String userID;
  pill({@required this.userID});
  @override
  Widget build(BuildContext context) {
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
          title: Text('WeCare',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  'Every Dose, Every Day',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.volume_up),
                    //tooltip: 'Increase volume by 10',
                    onPressed: () {
                      final player= AudioCache();
                      player.play("pills.mp3");
                    },
                  ),
                ],
              ),
              SizedBox(
                  height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_5,
                          size: 100,
                        ),
                        Text('Morning',
                          style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.wb_sunny,
                          size: 100,
                        ),
                        Text('Afternoon',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_4,
                          size: 100,
                        ),
                        Text('Evening',
                          style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,
                            width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.brightness_3,
                          size: 100,
                        ),
                        Text('Night',
                          style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                  RaisedButton(
                    onPressed: (){

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return AddNewPill(userID: this.userID);
                        }),
                      );
                    },
                    textColor: Colors.black,
                    color: Color(0xFFFEC0B2),
                    child: Text('New'),
                  ),

                  SizedBox(

                    width: 30,

                  ),

                  RaisedButton(

                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return displayPills(userID :this.userID);
                        }),
                      );

                    },

                    textColor: Colors.black,

                    color: Color(0xFFFEC0B2),

                    child: Text('All'),

                  )

                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}