import 'package:admin_plantshopee/controller/notifications.dart';
import 'package:admin_plantshopee/firebase/database.dart';
import 'package:flutter/material.dart';

import 'package:admin_plantshopee/customWidgets/chat_container.dart';
import 'package:admin_plantshopee/firebase/chat_api.dart';
import 'package:admin_plantshopee/model/chat_model.dart';
import 'package:admin_plantshopee/model/user_model.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  String userId;
  String id;
  ChatScreen({
    Key? key,
    required this.userId,
    required this.id,
  }) : super(key: key);

  final _messageController = TextEditingController();
  final _notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ChatModel>>(
                      stream: ChatApi.getChart(userId, id),
                      builder: ((context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text("Hay, How may Help you"),
                            );
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: ((context, index) {
                                  final chat = snapshot.data![index];

                                  return ChatContainer(
                                      message: chat.message, isMe: chat.itsMe);
                                }));
                          }
                        }
                      })),
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: 'Type your message',
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(width: 0),
                                gapPadding: 10,
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                        onTap: () {
                          sendMessage(context);
                        },
                        child: const CircleAvatar(
                          radius: 26,
                          child: Icon(Icons.send),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage(BuildContext context) {
    String message = _messageController.text.trim();
    // String token = await getToken(userId);
    FocusScope.of(context).unfocus();
    ChatApi.sendMessage(userId, id, _messageController.text.trim())
        .then((value) {
      _notificationController.sendPushMessage(
          _notificationController.mtoken!, message, 'New Message');
    });
    _messageController.clear();
  }
}
