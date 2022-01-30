import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/text_message_entity.dart';
import '../model/text_message_model.dart';
import '../model/user_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> signUp(String email, String password);

  Future<void> signIn(String email, String password);

  Future<void> signOut();

  Future<bool> isSignIn();

  Future<String> getCurrentUid();

  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl);

  Future<void> sendTextMessage(TextMessageEntity textMessage, String s);

  Stream<List<UserModel>> getUsers();

  Stream<List<TextMessageModel>> getMessages(String s);
}

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _meetUpChannelCollection =
      FirebaseFirestore.instance.collection("meetUpAppChannel");

  late String channelId;

  @override
  Future<String> getCurrentUid() async => _auth.currentUser?.uid as dynamic;

  @override
  Future<bool> isSignIn() async => _auth.currentUser?.uid != null;

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(
      String email, String name, String profileUrl) async {
    _userCollection.doc(_auth.currentUser?.uid).get().then((user) {
      if (!user.exists) {
        final newUser = UserModel(
          name: name,
          email: email,
          uid: _auth.currentUser?.uid,
          profileUrl: profileUrl,
        ).toDocument();
        _userCollection.doc(_auth.currentUser?.uid).set(newUser);
        return;
      } else {
        print("User Already exists");
        return;
      }
    });
  }

  @override
  Stream<List<TextMessageModel>> getMessages(String s) {
    if (s == 'Cricket') {
      channelId = 'Es2DhiuLw3SRpOIInhVp';
    } else if(s=='Football') {
      channelId = "e0OuYvWUi8GIfqX9kjAI";
    }else if(s=='Hockey') {
      channelId='uNrKENMu05Qv0ONq6OeS';
    } else {
      channelId='kXrIX3T4Xxf8cL5YRjrG';
    }
    return _meetUpChannelCollection
        .doc(channelId)
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TextMessageModel.fromSnapshot(docSnapshot))
            .toList());
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return _userCollection.snapshots().map(
          (querySnapShot) => querySnapShot.docs
              .map((docSnapshot) => UserModel.fromSnapshot(docSnapshot))
              .toList(),
        );
  }

  @override
  Future<void> sendTextMessage(TextMessageEntity textMessage, String s) async {
    if (s == 'Cricket') {
      channelId = 'Es2DhiuLw3SRpOIInhVp';
    } else if(s=='Football') {
      channelId = "e0OuYvWUi8GIfqX9kjAI";
    }else if(s=='Hockey') {
      channelId='uNrKENMu05Qv0ONq6OeS';
    } else {
      channelId='kXrIX3T4Xxf8cL5YRjrG';
    }
    final newMessage = TextMessageModel(
      message: textMessage.message,
      recipientId: textMessage.recipientId,
      time: textMessage.time,
      receiverName: textMessage.receiverName,
      senderId: textMessage.senderId,
      senderName: textMessage.senderName,
      type: textMessage.type,
    );
    _meetUpChannelCollection
        .doc(channelId)
        .collection("messages")
        .add(newMessage.toDocument());
  }
}
