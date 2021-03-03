
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/groupChatScreen.dart';
import 'package:we_care/personalChatScreen.dart';
import 'package:we_care/searchChat.dart';

import 'HomePage.dart';

class chatList extends StatefulWidget{
  chatList({this.userID});
  String userID;
  @override
  _chatListState createState() => _chatListState();
}

class _chatListState extends State<chatList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    return HomePage(userID: widget.userID);
                  }));
            },
          ),
          title: Text('My Chats',
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: Column(
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'My Groups',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance.collection('users').document(widget.userID).collection('groupChatList').getDocuments(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final ListData= snapshot.data.documents.reversed;
                  List<String> userchatListData=[];
                  for(var chatList in ListData){
                    final chat= chatList.data['id'];
                    userchatListData.add(chat);
                  }
                  return FutureBuilder<QuerySnapshot>(
                    future: Firestore.instance.collection('groupChats').orderBy('timestamp').getDocuments(),
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
                        final chatListData= snapshot.data.documents.reversed;
                        List<chatListTile> chatListDataWidgets=[];
                        for(var chatList in chatListData){
                          final groupName= chatList.data['name'];
                          final chatId= chatList.data['id'];
                          final time=chatList.data['time'];
                          if(userchatListData.contains(chatId)){
                            final chatListWidget= chatListTile(name: groupName, chatId: chatId, userID: widget.userID, time: time);
                            chatListDataWidgets.add(chatListWidget);
                          }
                        }
                        return Expanded(
                          child: ListView(
                            children: chatListDataWidgets,
                          ),
                        );
                      }
                    },
                  );
                }
            ),

            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'My Friends',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 2,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            FutureBuilder(
                future: Firestore.instance.collection('users').document(widget.userID).collection('personalChatList').getDocuments(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final ListData= snapshot.data.documents.reversed;
                  List<String> userchatListData=[];
                  for(var chatList in ListData){
                    final chat= chatList.data['id'];
                    userchatListData.add(chat);
                  }
                  return FutureBuilder(
                      future: Firestore.instance.collection('personalChats').orderBy('timestamp').getDocuments(),
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
                          final chatListData= snapshot.data.documents.reversed;
                          List<personalChatListTile> chatListDataWidgets=[];
                          for(var chatList in chatListData){
                            final chatId= chatList.data['id'];
                            final member1= chatList.data['member1'];
                            final member2=chatList.data['member2'];
                            final time=chatList.data['time'];
                            String receiverID;
                            if(member1==widget.userID)
                            {
                              receiverID=member2;
                            }
                            else{
                              receiverID=member1;
                            }
                            if(userchatListData.contains(chatId))
                              {
                                final chatListWidget= personalChatListTile(chatId: chatId, senderID: widget.userID,
                                    receiverID: receiverID ,time: time);
                                chatListDataWidgets.add(chatListWidget);
                              }
                          }
                          return Expanded(
                            child: Column(
                              children: chatListDataWidgets,
                            ),
                          );
                        }
                      }

                  );
                }
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 25.0, right: 25.0),
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return searchChat(userID: widget.userID, );
                          }));
                    },
                    backgroundColor: Color(0xFFFEC0B2),
                    child: Icon(Icons.search,
                    color: Colors.black,),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
class personalChatListTile extends StatelessWidget{
  personalChatListTile({this.chatId, this.senderID, this.receiverID, this.time});
  String chatId, senderID, receiverID, time;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document(receiverID).get(),
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
          return GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return PersonalChatScreen(name: name, chatId: chatId, userID:senderID);
                  }));
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10),
                        child: Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0, top: 10.0, bottom: 10),
                        child: Text(time,
                          style: TextStyle(
                              fontSize: 15
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ],
            ),
          );
        }
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
class chatListTile extends StatelessWidget{
  chatListTile({this.name, this.chatId, this.userID, this.time});
  String name, chatId, userID, time;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return GroupChatScreen(name: name, chatId: chatId, userID:userID);
            }));
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 10.0, bottom: 10),
                  child: Text(name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 25.0, top: 10.0, bottom: 10),
                  child: Text(time,
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}