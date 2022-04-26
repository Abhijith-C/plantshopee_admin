import 'dart:convert';

class ChatModel {
  String userId;
  String? orderId;
  String message;
  DateTime createdAt;
  bool itsMe;
  ChatModel({
    required this.userId,
   this.orderId,
    required this.message,
    required this.createdAt,
    required this.itsMe,
  });
  

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'orderId': orderId,
      'message': message,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'itsMe': itsMe,
    };
  }

  static ChatModel fromJson(Map<String, dynamic> map) {
    return ChatModel(
      userId: map['userId'] ?? '',
      orderId: map['orderId'] ?? '',
      message: map['message'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      itsMe: map['itsMe'] ?? false,
    );
  }

  
}
