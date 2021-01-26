import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  final String id;
  final String email;
  final String displayName;

  User ({
    this.id,
    this.email,
    this.displayName,
});
  factory User.fromDocument(DocumentSnapshot doc){
    return User(
      id: doc['id'],
      email: doc['email'],
      displayName: doc['displayName'],
    );
  }
}