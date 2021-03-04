import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/chatList.dart';
import 'package:we_care/personalChatScreen.dart';

import 'groupChatScreen.dart';

class searchChat extends StatefulWidget{
  @override
  searchChat({this.userID});
  String userID;

  @override
  _searchChatState createState() => _searchChatState();
}

class _searchChatState extends State<searchChat> {
  TextEditingController searchText=new TextEditingController();
  String search;
  Color group = Colors.grey, friends =Colors.white;
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.black,),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return chatList(userID: widget.userID);
                  }));
            },
          ),
          title: TextField(
            decoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.only(top: 0,bottom: 0),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
                borderRadius: new BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(Icons.search),
              suffixIcon: Icon(Icons.clear),
              labelText: 'Search',
              fillColor: Colors.white,
            ),
            onChanged: (text){
              setState(() {
                searchText.text= text;
              });
            }
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: Container(
                      width: size.width* .50,
                      color: group,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(child: Text('Groups')),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        group= Colors.grey;
                        friends=Colors.white;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: size.width* .50,
                      color: friends,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(child: Text('Friends')),
                      ),
                    ),
                      onTap: (){
                        setState(() {
                          group= Colors.white;
                          friends=Colors.grey;
                        });
                      },
                  )
                ],
              ),
              (searchText.text=="")?nocontentscreen(size): (group==Colors.grey)?
              searchList(searchText.text, widget.userID): searchPersonalList(searchText.text, widget.userID)
            ],
          ),
        )//(searchText.text=="")?nocontentscreen(size):searchList(searchText.text, widget.userID)
      )
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
searchPersonalList(String searchText, String userID){
  return Column(
    children: [
      Divider(
        thickness: 2,
      ),
      FutureBuilder(
        future: Firestore.instance.collection('users').document(userID).collection('personalChatList').getDocuments(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
            final ListData = snapshot.data.documents.reversed;
            List<String> userchatListData = [];
            for (var chatList in ListData) {
              final chat = chatList.data['id'];
              userchatListData.add(chat);
            }
            return FutureBuilder(
              future: Firestore.instance.collection('users').where(
                  'username', isGreaterThanOrEqualTo: searchText).getDocuments(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final searchData = snapshot.data.documents;
                  List<searchFriendsTile> searchDataWidgets = [];
                  for (var search in searchData){
                    final username = search.data['username'];
                    final id = search.data['id'];
                    if(id!=userID){
                      final searchWidget= searchFriendsTile(username: username, userID: userID,id: id, userchatListData: userchatListData);
                      searchDataWidgets.add(searchWidget);
                    }
                  }
                  return Column(
                    children: searchDataWidgets,
                  );
                }
            );
          }
      )
    ],
  );
}
class searchFriendsTile extends StatelessWidget{
  @override
  searchFriendsTile({this.username, this.userID, this.id, this.userchatListData});
  String username, userID, id;
  String chatId;
  List<String> userchatListData=[];
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance.collection('users').document(userID).get(),
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
        String senderUsername = data['username'];
        return GestureDetector(
          onTap: (){
            if(senderUsername.compareTo(username)>0){
              chatId=senderUsername+username;
            }
            else{
              chatId=username+senderUsername;
            }
            if(!userchatListData.contains(chatId)){
              Firestore.instance.collection('users').document(userID).collection('personalChatList').add({
                "id":chatId
              });
              Firestore.instance.collection('users').document(id).collection('personalChatList').add({
                "id":chatId
              });
              Firestore.instance.collection('personalChats').document(chatId).setData({
                "id": chatId,
                "lastText": "",
                "member1": userID,
                "member2": id,
                "time": "",
                "timestamp": DateTime.now()
              });
            }
            Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return PersonalChatScreen(name: username, chatId: chatId, userID:userID);
                }));
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top:10, bottom: 10, left: 10),
                  child: Text(
                    username, style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0, right: 8),
                child: Divider(
                  thickness: 2,
                ),
              )
            ],
          ),
        );
      }
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
searchList(String searchText, String userID){
  return Column(
    children: [
      Divider(
        thickness: 2,
      ),
      FutureBuilder(
        future: Firestore.instance.collection('users').document(userID).collection('groupChatList').getDocuments(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                ),
              );
            }
            final ListData = snapshot.data.documents.reversed;
            List<String> userchatListData = [];
            for (var chatList in ListData) {
              final chat = chatList.data['id'];
              userchatListData.add(chat);
            }
            return FutureBuilder(
                future: Firestore.instance.collection('groupChats').where(
                    'name', isGreaterThanOrEqualTo: searchText).getDocuments(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      ),
                    );
                  }
                  final searchData = snapshot.data.documents;
                  List<searchTile> searchDataWidgets = [];
                  for (var search in searchData) {
                    final groupName = search.data['name'];
                    final id = search.data['id'];
                    final searchWidget = searchTile(
                        name: groupName, id: id, userID: userID, userchatListData: userchatListData);
                    searchDataWidgets.add(searchWidget);
                  }
                  return Column(
                    children: searchDataWidgets,
                  );
                }
            );
          }
      ),

    ],
  );
}
class searchTile extends StatelessWidget{
  @override
  searchTile({this.name, this.id, this.userID, this.userchatListData});
  String name, id, userID;
  List<String> userchatListData=[];
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(!userchatListData.contains(id)){
          Firestore.instance.collection('users').document(userID).collection('groupChatList').add({
            "id":id
          });
        }
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return GroupChatScreen(name: name, chatId: id, userID:userID);
            }));
      },
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top:10, bottom: 10, left: 10),
              child: Text(
                name, style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0, right: 8),
            child: Divider(
              thickness: 2,
            ),
          )
        ],
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
nocontentscreen(var size){
  return ListView(
    shrinkWrap: true,
    children: [
      Container(
        height: size.height * .30,
      ),
      Icon(Icons.search,
        size: 50,),
      Text('Find Groups or Users',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25
        ),
      ),
    ],
  );
}