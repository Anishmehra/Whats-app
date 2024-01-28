import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watsapppp/CreaateProfilePage/user_models.dart';
import 'package:watsapppp/chatsPage/TalkinPage.dart';

class Contact extends StatelessWidget {
  Contact({super.key});
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   FirebaseAuth auth = FirebaseAuth.instance;

   var currentUserId = FirebaseAuth.instance.currentUser?.uid != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("Contacts"),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {

          var users = snapshot.data?.docs;

          return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                var userData = users[index].data() as Map<String, dynamic>;
                var user = userModel.fromMap(userData);

                    if (user.uid == FirebaseAuth.instance.currentUser?.uid) {
              return SizedBox.shrink(); 
             }  
                return Column(
                  children:[
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(user.profilePic),
                        ),

                                    title: Text("${user.name}",style: TextStyle(color: Colors.white,fontSize:15 ),),
                                        onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>TalkingPage(name: user.name,uid: user.uid, profilePic: user.profilePic,)));
                                        },
                                      ),
                    )
                ]
                );
              },
          );
        },
      ),
    );
  }
}
