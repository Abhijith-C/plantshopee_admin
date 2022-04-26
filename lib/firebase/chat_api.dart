import 'package:admin_plantshopee/model/chat_model.dart';
import 'package:admin_plantshopee/model/order_model.dart';
import 'package:admin_plantshopee/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatApi {
  static Future sendMessage(String userId, String orderId, String message) async {
    final chatCollection = FirebaseFirestore.instance
        .collection('chats')
        .doc(userId)
        .collection('messages').doc(orderId).collection('chat');
    final newMessage = ChatModel(
        userId: userId,
        orderId: orderId,
        message: message,
        itsMe: false,
        createdAt: DateTime.now(),
       );

    chatCollection.add(newMessage.toJson());
  }

  static Stream<List<ChatModel>> getChart(String userId, String orderId) =>
      FirebaseFirestore.instance
          .collection('chats')
          .doc(userId)
          .collection('messages').doc(orderId).collection('chat')
          .orderBy('createdAt', descending: false)
          .snapshots()
          .map((event) =>
              event.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
}
