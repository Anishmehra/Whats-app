import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';


import 'package:watsapppp/CreaateProfilePage/auth_controler.dart';


class CreateYourProfilePage extends ConsumerStatefulWidget {
   CreateYourProfilePage({super.key});

  @override
  ConsumerState<CreateYourProfilePage> createState() => _CreateYourProfilePageState();
}

class _CreateYourProfilePageState extends ConsumerState<CreateYourProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance; 
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage store = FirebaseStorage.instance;
  TextEditingController _controller = TextEditingController();
   File? image;
    Future<void> _getimage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

void Storeuserdata() async {
  String name = _controller.text.trim();
  if(name.isNotEmpty){
    ref.read(AuhtControllerProvider).saveUseraDataToFirebase(context, name, image);
  }

}

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title:Text("Create Your profile",style: TextStyle(color: Colors.white),) ,
        centerTitle: true,
        actions: [GestureDetector( 
          onTap:Storeuserdata,
          child: Icon(Icons.arrow_forward,color: Colors.white
          ,),
          
        ),
      ],
       leading: GestureDetector(
          onTap: () {
            
         Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      backgroundColor: Colors.blueGrey[800],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(padding: EdgeInsets.only(left : 10,top: 50),  
          child: CircleAvatar(
                radius: 50, 
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image == null ? Icon(Icons.person, size: 40,) : null,
          )
          ), 
          Padding(
            padding: const EdgeInsets.only(
              top:120, 
              left: 90
            ),
            child: GestureDetector(
              onTap: () {
                _getimage();
              },
              child: CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage("assets/vector-illustration-camera-plus-icon-260nw-2178512517.webp"),)
            ),
          )
            ],
          ), 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller, 
              decoration: InputDecoration(
                border: UnderlineInputBorder()
              ),
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}