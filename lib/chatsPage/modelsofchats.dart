import 'package:cloud_firestore/cloud_firestore.dart';

class chatmessage {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  chatmessage({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory chatmessage.fromMap(Map<String, dynamic> map) {
    return chatmessage(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
