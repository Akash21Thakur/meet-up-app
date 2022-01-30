

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({ String? name,  String? email,  String? uid, String? profileUrl})
      : super(name.toString(), email.toString(), uid.toString(), profileUrl.toString());

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        name: json['name'],
        profileUrl: json['profileUrl'],
        email: json['email'],
        uid: json['uid']
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return UserModel(
      name: (documentSnapshot.data()as dynamic)['name'],
      uid: (documentSnapshot.data() as dynamic)['uid'],
      email: (documentSnapshot.data() as dynamic)['email'],
      profileUrl: (documentSnapshot.data() as dynamic)['profileUrl'],
    );
  }
  Map<String,dynamic> toDocument(){
    return {
      "name" :name,
      "uid" :uid,
      "email":email,
      "profileUrl":profileUrl,
    };
  }
}
