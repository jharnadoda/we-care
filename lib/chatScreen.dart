import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class chatScreen extends StatelessWidget{
  @override
  String userID;
  chatScreen({@required this.userID});
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('<    FYP',
          style: TextStyle(
              color: Colors.black
          ),
        ),
        backgroundColor: Color(0xFFFEC0B2),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Row (
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Send Message',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                              )
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Colors.white,
                      child: Text('Send'),
                      onPressed: (){},
                    )
                  ],
                ),
              ),
            ),
          ],
        )/*Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 15,
            ),
            Align(
            alignment: Alignment.centerRight,
              child: Text('Jannat'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                Container(
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      color: Color(0xFFFEC0B2),
                      border: Border.all(color: Colors.black,
                          width: .5),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Hi Aarushi and Jharna!'),
                  ),
                ),
              ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Aarushi'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC0B2),
                          border: Border.all(color: Colors.black,
                              width: .5
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Hi Jannat!'),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Jharna'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC0B2),
                          border: Border.all(color: Colors.black,
                              width: .5
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Hello!'),
                      ),
                    ),
                  ]
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text('Jannat'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC0B2),
                          border: Border.all(color: Colors.black,
                              width: .5),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('We have a ppt tomorrow'),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Jharna'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC0B2),
                          border: Border.all(color: Colors.black,
                              width: .5
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Yes, I remember'),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Aarushi'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFFFEC0B2),
                          border: Border.all(color: Colors.black,
                              width: .5
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Ok! Lets prepare'),
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row (
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          )
                      ),
                    ),
                  ),
                ),
                FlatButton(
                  color: Colors.white,
                  child: Text('Send'),
                  onPressed: (){},
                )
              ],
            ),
          ],
        )*/
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
