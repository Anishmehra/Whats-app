import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageChat extends StatefulWidget {
 final String messages;
  final bool inCurrentUser;
  final DateTime? timestamp;

  const MessageChat({
    Key? key,
    required this.messages,
    required this.inCurrentUser,
    required this.timestamp,
  }) : super(key: key);

  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {

  String formatTime(DateTime? time) {
    return time != null
        ? DateFormat.jm().format(time)
        : 'Timestamp not available'; 
      }

  Future<void> showMessageList() async{
    var messagesId =FirebaseFirestore.instance.
                collection('Chats')
                .doc()
                .collection('Messages')
                .doc();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
             ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor:  Colors.blueGrey[800],
            content: Column( 
              children: [
              IconButton(
                  icon: Icon(Icons.delete,color: Colors.white,),
                  onPressed: () {
                   deleteMessage();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.forward,color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

              ],
            ),
          ),
        );
      },
      child: Align(
        alignment: widget.inCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.symmetric(vertical:30, horizontal: 30),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(27, 158, 158, 158),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.messages,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 5.0),
              Text(
                formatTime(widget.timestamp),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

