import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/text_message_entity.dart';

class TextMessageModel extends TextMessageEntity {
  const TextMessageModel({
    required String recipientId,
    required String senderId,
    required String senderName,
    String type = "TEXT",
    required Timestamp time,
    required String message,
    required String receiverName,
  }) : super(
          recipientId,
          senderId,
          senderName,
          type,
          time,
          message,
          receiverName,
        );

  factory TextMessageModel.fromJson(Map<String, dynamic> json) {
    return TextMessageModel(
      recipientId: json['recipientId'],
      message: json['message'],
      time: json['time'],
      receiverName: json['receiverName'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      type: json['type'],
    );
  }

  factory TextMessageModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TextMessageModel(
      time: (documentSnapshot.data() as dynamic)['time'],
      message: (documentSnapshot.data() as dynamic)['message'],
      receiverName: (documentSnapshot.data() as dynamic)['receiverName'],
      recipientId: (documentSnapshot.data() as dynamic)['recipientId'],
      senderId: (documentSnapshot.data() as dynamic)['senderId'],
      senderName: (documentSnapshot.data() as dynamic)['senderName'],
      type: (documentSnapshot.data() as dynamic)['type'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "recipientId": recipientId,
      "senderId": senderId,
      "senderName": senderName,
      "type": type,
      "time": time,
      "message": message,
      "receiverName": receiverName
    };
  }
}
