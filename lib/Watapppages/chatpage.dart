import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watsapppp/CreaateProfilePage/user_models.dart';
import 'package:watsapppp/chatsPage/TalkinPage.dart';
import 'package:watsapppp/select_contact/contact.dart';

class chatPages extends StatelessWidget {
  chatPages({super.key});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var currentUserId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Stack(
        children: [
          Expanded(child:
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              var users = snapshot.data?.docs;

                if (users == null) {
                  return CircularProgressIndicator(); 
                }
              return ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  var userData = users[index].data() as Map<String, dynamic>;
                  var user = userModel.fromMap(userData);
                  
                  if (user.uid == currentUserId) {
                    return SizedBox.shrink(); 
                  }
                  var conversationExists = checkConversationExists(user.uid);

                  if (conversationExists == false) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(user.profilePic),
                          ),
                          title: Text(
                            "${user.name}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TalkingPage(
                                  name: user.name,
                                  uid: user.uid,
                                  profilePic: user.profilePic,
                                ),
                              ),
                            );
                          },
                        ),
                      ), 
                    ],
                  );
                },
              );
            },
          ),
          ),
           Padding(
              padding: const EdgeInsets.only(top: 650, left: 310),
              child: FloatingActionButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Contact()));
              }, 
              backgroundColor: Color.fromARGB(197, 29, 239, 197),
              child: Icon(Icons.message, color: Colors.black,),
              elevation: null,
              ),
          )
        ],
      ),
    );
  }

  Future<bool> checkConversationExists(String contactUid) async {
  var result = await firestore
      .collection('chats')
      .where('senderId', isEqualTo: currentUserId)
      .where('receiverId', isEqualTo: contactUid)
      .limit(1)
      .get();

  return result.docs.isNotEmpty;
}

}


