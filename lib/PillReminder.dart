import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/AddNewPill.dart';
import 'displayPills.dart';
class pill extends StatelessWidget{
  final String email;
  pill({@required this.email});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                height: 5,
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
                          return AddNewPill(email: this.email);
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
                          return displayPills(email: this.email);
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