import 'package:flutter/material.dart';
import 'package:watsapppp/Watapppages/chatpage.dart';
import 'package:watsapppp/Watapppages/classesofpages.dart';


class archivedPage extends StatelessWidget {
   archivedPage({super.key});

    List <chatPage> _listchats = [
     // chatPage(name: "Heartless Girl 😖", imagePath: "assets/IMG-20230305-WA0044.jpg", message: "hello"),
       chatPage(name: "Ambuj", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.18.52_e216c4da.jpg", message: "hello"), 
        chatPage(name: "Abhisek", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.18.19_617bd7af.jpg", message: "hi"), 
         chatPage(name: "Adity", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.19.37_6d9fc0e1.jpg", message: "hello"), 
          chatPage(name: "Ashutosh", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.25.34_ec7ea3c4.jpg", message: "hello"), 
           chatPage(name: "Ankit", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.27.04_5f89c620.jpg", message: "hello"), 
            chatPage(name: "Sanskar", imagePath: "assets/WhatsApp Image 2024-01-03 at 15.28.43_e1bfe93d.jpg", message: "hello"), 
            // chatPage(name: "Heartless Girl 😖", imagePath: "assets/IMG-20230305-WA0044.jpg", message: "hello"),  

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            title: Text("Archived",style: TextStyle(color: Colors.white),),
            backgroundColor:Color.fromARGB(255, 55, 131, 93),
            actions: [
              Icon(Icons.more_vert,color: Colors.white,)
            ],
            leading: Builder(builder: (context)=>GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)
              ),
          ),
      ),
      body: Column(

        children: [

         Padding(padding: EdgeInsets.only(top: 20),
         child: Column(
            children: [
          Center(child: Text("These chat stay archived when new message are ",style: TextStyle(color: Colors.grey),)),
          Center(child: Text("recived.Tap to change",style: TextStyle(color: Colors.grey)))
            ],
         ),), 
          Expanded(
          child: ListView.builder(
            itemCount: _listchats.length,
            itemBuilder: (context, builder) {
              chatPage _chatPage = _listchats[builder];
            return Container(
              padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(_chatPage.imagePath), 
                    ),
                    SizedBox(width: 15,), 
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_chatPage.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text(_chatPage.message,style: TextStyle(fontSize: 15),)
                      ],
                    )
                  ],
                ),
            );
          }),
        ),
        ]
        ,
      ),
    );
  }
}