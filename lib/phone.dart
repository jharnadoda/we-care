import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_care/models/users.dart';
import 'otp.dart';
import 'signup_volunteer.dart';
import 'HomePage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn= GoogleSignIn();
final usersRef= Firestore.instance.collection('users');
final DateTime timestamp=DateTime.now();
User currentUser;
String ID;
void main() {
  runApp(phone());
}

class phone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                phone_v(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class phone_v extends StatefulWidget {
  @override
  _phone_vState createState() =>_phone_vState();
}

class _phone_vState extends State<phone_v> {
  bool isAuth= false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account)
    {
      if(account!=null)
        {
          createUserInFirestore();
          print('User Signed in: $account');
          setState(() {
            isAuth=true;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));
        }
      else{
        setState(() {
          isAuth=false;
        });
      }
    },
    onError: (err){
      print('Error Signing In: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account){
      if(account!=null)
      {
        createUserInFirestore();
        print('User Signed in: $account');
        setState(() {
          isAuth=true;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      }
      else{
      setState(() {
        isAuth=false;
      });
      }
    }).catchError((err){
      print('Error Signing In: $err');
    });
  }
  createUserInFirestore() async{
    final GoogleSignInAccount user= googleSignIn.currentUser;
    DocumentSnapshot doc= await usersRef.document(user.id).get();

    if(!doc.exists) {
      print('Create an Account');
      usersRef.document(user.id).setData({
        "id": user.id,
        "email": user.email,
        "displayName": user.displayName,
        "timestamp": timestamp
      });
      doc= await usersRef.document(user.id).get();
    }
    currentUser = User.fromDocument(doc);
    print(currentUser.email);
  }
  @override
  final _phoneController=TextEditingController();
  final _codeController= TextEditingController();
  Future<bool> loginuser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop;
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;
          if (user != null) {
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePage();
              }));
            }
          }
          else{
            print('Error');
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int ForceResendingToken]) {
      showDialog(context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
        title: Text('Enter the code'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _codeController,
            )
          ],
        ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () async{
                final code= _codeController.text.trim();
                AuthCredential credential= PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);
                AuthResult result= await _auth.signInWithCredential(credential);
                FirebaseUser user = result.user;
                if (user != null) {
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                  }
                }
                else{
                  print('Error');
                }
              },
            )
          ],
                    );
      }
      );
        },
        codeAutoRetrievalTimeout: null);
}
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 175),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:5),
                child: IconButton(
                  icon: Icon(Icons.volume_up),
                  //tooltip: 'Increase volume by 10',
                  onPressed: () {
                    final player= AudioCache();
                    player.play("login.mp3");
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 75),
          Padding(
            padding:
            const EdgeInsets.only(left: 15, top: 0.0, right: 15.0, bottom: 0.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.phone),
                labelText: 'Enter Phone Number ',
                fillColor: Colors.teal[100],
              ),
              controller: _phoneController,
            ),
          ),
          SizedBox(height: 75),
          RaisedButton(
            onPressed: () {
              final phone= _phoneController.text.trim();
              loginuser(phone,context);
              //Navigator.push(context, MaterialPageRoute(builder: (context) {
               // return otp();
              //}
             // )

            },
            color: Color(0xFFFEC0B2),
            textColor: Colors.black,
            child: Text('Next'),

          ),
          SizedBox(
            height: 10,
          ),
          Text(
              'OR',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SignInButton(
            Buttons.GoogleDark,
            text: "Sign up with Google",
            onPressed: () {
              googleSignIn.signIn();
            },
          )

        ],
      ),
    );
  }
}
