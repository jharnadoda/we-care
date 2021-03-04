import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_care/Exercises.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class showWorkouts extends StatelessWidget{
  @override
  showWorkouts({this.userID, this.name, this.exerciseID});
  String userID, name, exerciseID;
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
                    return exercises(userID: userID);
                  }));
            },
          ),
          title: Text(name ,
            style: TextStyle(
                color: Colors.black
            ),
          ),
          backgroundColor: Color(0xFFFEC0B2),
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: Firestore.instance.collection('exercises').document(exerciseID).collection('workouts').getDocuments(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData)
                {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }
                final exerciseData= snapshot.data.documents;
                List<exerciseTile> exerciseDataWidgets=[];
                for(var exercise in exerciseData){
                  final title=exercise.data['name'];
                  final url=exercise.data['url'];
                  final exerciseWidget= exerciseTile(title: title, url: url,);
                  exerciseDataWidgets.add(exerciseWidget);
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ListView (
                    children: exerciseDataWidgets,
                  ),
                );
              }

          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}
class exerciseTile extends StatelessWidget{
  @override
  exerciseTile({this.title, this.url});
  String title, url;
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        loop: false,
        disableDragSeek: false,
        isLive: false,
        forceHD: false,

      ),
    );
    // TODO: implement build
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.bold
          ),),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
          ),
        ),
        SizedBox(height: 5,),
        Divider(thickness: 2,
        color: Colors.black38,)
      ]
    );
    throw UnimplementedError();
  }

}
