import 'package:admin_plantshopee/constance/constance.dart';
import 'package:admin_plantshopee/controller/notifications.dart';
import 'package:admin_plantshopee/firebase/database.dart';
import 'package:flutter/material.dart';

import 'package:admin_plantshopee/customWidgets/chat_container.dart';
import 'package:admin_plantshopee/firebase/chat_api.dart';
import 'package:admin_plantshopee/model/chat_model.dart';
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
  final NotificationController _notificationController = Get.find();

  @override
  Widget build(BuildContext context) {
    _notificationController.updateToken(userId);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('Plantshopee Support',style: subHeading,),
        ),
        body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(width: double.infinity,height: size.height*0.3,color: Colors.blue,),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("User id : $userId"),
                     const SizedBox(height: 10,),
                    Text('Order id : $id'),
                    ],),
                  ),
                ),
                Container(
                  margin:  EdgeInsets.only(top: size.height*0.07),
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 70),
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
                ),
                
              ],
            ))
        
        );
  }

  void sendMessage(BuildContext context) {
    String message = _messageController.text.trim();
    FocusScope.of(context).unfocus();
    ChatApi.sendMessage(userId, id, message).then((value) {
      _notificationController.sendPushMessage(
          _notificationController.mtoken!, message, 'New Message');
    });
    _messageController.clear();
  }
}
