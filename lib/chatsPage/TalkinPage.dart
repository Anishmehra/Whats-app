import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:watsapppp/chatsPage/messagePage.dart';


class TalkingPage extends ConsumerStatefulWidget {
  String name;
  String uid;
  String profilePic;

  TalkingPage({
    Key? key,
    required this.name,
    required this.uid,
    required this.profilePic,
  }) : super(key: key);

  @override
  ConsumerState<TalkingPage> createState() => _TalkingPageState();
}

class _TalkingPageState extends ConsumerState<TalkingPage> {
  TextEditingController messageController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String chatId = '';
  
@override
void initState() {
  super.initState();
  chatId = createUniqueChatId(currentUserId, widget.uid);
}
 String createUniqueChatId(String userId1, String userId2) {
  List<String> sortedIds = [userId1, userId2]..sort();
  return "${sortedIds[0]}_${sortedIds[1]}";
}
 
Future<void> sendMessage(String text) async {
  try {
    await firestore
        .collection('Chats')
        .doc(chatId)
        .collection('Messages')
        .add({
          'text': text,
          'senderId': currentUserId,
          'timestamp': FieldValue.serverTimestamp(),
        });
  } catch (e) {
    print('Error sending message: $e');
  }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(widget.name),
      ),
      body:  Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: firestore
                .collection('Chats')
                .doc(chatId)
                .collection('Messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
               print('StreamBuilder triggered');
              if (snapshot.hasData) {
                List<DocumentSnapshot> messages = snapshot.data!.docs;

                return showMessageInScreen(messages: messages, currentUserId:currentUserId,chatId:chatId);
              } else {
                return Text("chat Start");
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  sendMessage(messageController.text);
                  messageController.clear();
                },
              ),
            ],
          ),
        ),
      ],
    ),
    );
    
  }
}
@override
Widget showMessageInScreen({required List<DocumentSnapshot<Object?>> messages,required String currentUserId,}) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      itemBuilder: (context, index) {
    var timestamp = messages[index]['timestamp'];
    DateTime? messageTime = timestamp != null ? timestamp.toDate() : null;
        return MessageChat(
          messages: messages[index]['text'],
          inCurrentUser: messages[index]['senderId'] == currentUserId,
           timestamp: messageTime,
           chatId: 
        );
      },
    );
  }

  // @override
  // Widget MessageChat({required String messages, required bool inCurrentUser,required DateTime? timestamp}) {
  //    String formatTime(DateTime? time) {
  //   return time != null
  //       ? DateFormat.jm().format(time)
  //       : 'Timestamp not available'; 
  //     }
  //   return Align(
  //     alignment: inCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical:30, horizontal: 30),
  //       padding: EdgeInsets.all(10.0),
  //       decoration: BoxDecoration(
  //         color: const Color.fromARGB(27, 158, 158, 158),
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             messages,
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           SizedBox(height: 5.0),
  //           Text(
  //             formatTime(timestamp),
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 12.0,
  //             ),
  //           ),
  //         ],
  //       ),
  //     )
  //   );
  // }


