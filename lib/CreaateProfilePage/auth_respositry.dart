import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watsapppp/CreaateProfilePage/common_firebase_repostiy.dart';
import 'package:watsapppp/CreaateProfilePage/user_models.dart';
import 'package:watsapppp/Watapppages/HeaderPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authproviderrepositry = Provider((ref) =>
    authrespositry(
        auth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
    ));

class authrespositry {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  authrespositry({required this.auth, required this.firestore});
  
  Future<userModel?> getCurrentUserDate() async{

          var UserData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
          userModel? user;
          if(UserData.data() != null){
            user = userModel.fromMap(UserData.data()!);
          }
          return user;
  }

  void saveuserdate({
    required String name,
    required File? profilePic,
    required BuildContext context,
    required ProviderRef ref,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photourl = 'assets/profilelogo.webp';
      
      if (profilePic != null) {
        photourl = await ref.read(commonFirebaseRepositry).storefiletostorage('profilepics$uid', profilePic);
      }

      var user = userModel(
        name: name,
        uid: uid,
        profilePic: photourl,
        isOnline: true,
        phoneNumber: auth.currentUser!.uid,
        groupId: [],
      );

      await firestore.collection("users").doc(uid).set(user.toMap());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => headerPage(),
        ),
        (route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}

