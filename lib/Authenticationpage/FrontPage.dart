import 'package:flutter/material.dart';
import 'package:watsapppp/Authenticationpage/numberValidation.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      backgroundColor: Colors.blueGrey[900],
       appBar: AppBar(
            centerTitle: true,
            title: Text("Welcome to WhatsApp",style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black87,
          ),
        body: Column(
          children: [  
            Padding(
              padding: const EdgeInsets.only(top: 50,right: 100,left: 100),
              child: CircleAvatar(
                radius: 100,
                    backgroundImage: AssetImage("assets/WhatsApp Image 2024-01-08 at 16.09.58_31a2c4d2.jpg"),
              ),
            ), 

            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50,left: 40,right: 20),
                  child: Row(
                    children: [
                      Text("Read out ",style: TextStyle(color: Colors.white),), 
                      Text("Privacy Policy",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                      Text("Tap Agree and Continue to",style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ), 
                Padding(padding:EdgeInsets.only(left: 120), 
                child: Row(
                  children: [
                    Text("accept the",style: TextStyle(color: Colors.white),), 
                    Text(" Terms of Services",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),

                  ],
                ),
                )
              ],
            ),

              Container(
                height: 30, 
                width: 350, 
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                    color: Color.fromARGB(197, 29, 239, 197), 
                    borderRadius: BorderRadius.all(Radius.circular(3))
                ),
              child: GestureDetector(
                onTap: () { 
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NumberValidationPage()));
                },
                child: Text("AGREE AND CONTINUE",style: TextStyle(fontWeight: FontWeight.bold),)),
              )
          ],
        ),
    );
    
  }
}