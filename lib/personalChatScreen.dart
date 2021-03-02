import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatList.dart';
class PersonalChatScreen extends StatefulWidget{
  PersonalChatScreen({this.name, this.chatId, this.userID});
  String name, chatId, userID;
  @override
  _PersonalChatScreenState createState() => _PersonalChatScreenState();
}
class _PersonalChatScreenState extends State<PersonalChatScreen>{
  TextEditingController messageController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return chatList(userID:widget.userID);
                  }));
            },
          ),
          title: Text(widget.name,
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection('personalChats').document(widget.chatId).collection('messages')
                    .orderBy('timestamp').snapshots(),
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
                    final chatData= snapshot.data.documents.reversed;
                    List<chatTile> chatDataWidgets=[];
                    for(var chat in chatData){
                      final sender= chat.data['senderId'];
                      final message=chat.data['message'];
                      final chatWidget=chatTile(senderID:sender, message:message, userID: widget.userID);
                      chatDataWidgets.add(chatWidget);
                    }
                    return Expanded(
                      child: ListView (
                        reverse: true,
                        children: chatDataWidgets,
                      ),
                    );
                  }
                }
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Row (
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                            hintText: 'Send Message',
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            )
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: IconButton(
                          icon: Icon(Icons.send,
                            color: Colors.black,),
                          onPressed: (){
                            DateTime timestamp= DateTime.now();
                            String time;
                            if(timestamp.minute<10){
                              time= "${timestamp.hour}:0${timestamp.minute}";
                            }
                            else{
                              time= "${timestamp.hour}:${timestamp.minute}";
                            }
                            Firestore.instance.collection('personalChats').document(widget.chatId).collection('messages').add({
                              "senderId": widget.userID,
                              "message" : messageController.text,
                              "timestamp": timestamp
                            },
                            );
                            Firestore.instance.collection('personalChats').document(widget.chatId)
                                .updateData({
                              'time': time,
                              'lastText': messageController.text,
                              'timestamp': timestamp
                            });
                            messageController.clear();
                          },
                        )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
class chatTile extends StatelessWidget{
  final String senderID, message, userID;
  chatTile({this.senderID,this.message, this.userID});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection('users').document(senderID).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(!snapshot.hasData)
          {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              ),
            );
          }
          Map<String, dynamic> data = snapshot.data.data;
          String name = data['displayName'];
          if(senderID==userID){
            return Padding(
              padding: const EdgeInsets.only(right: 10.0, top:10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(name),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFEC0B2),
                                border: Border.all(color: Colors.black,
                                    width: .5),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$message',
                                style: TextStyle(
                                    fontSize: 20
                                ),),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            );
          }
          else
          {
            return Padding(
              padding: const EdgeInsets.only(top:10.0, left: 10.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(name),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFEC0B2),
                                border: Border.all(color: Colors.black,
                                    width: .5),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('$message',
                                style: TextStyle(
                                    fontSize: 20
                                ),),
                            ),
                          ),
                        ]
                    ),
                  ),
                ],
              ),
            );
          }

        }
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}