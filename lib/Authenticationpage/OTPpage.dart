// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:watsapppp/CreaateProfilePage/creaqteProfile.dart';

class OTPpage extends StatefulWidget {
  String VarificationId;

  OTPpage({
    Key? key,
    required this.VarificationId,
  }) : super(key: key);

  @override
  State<OTPpage> createState() => _OTPpageState();
}

class _OTPpageState extends State<OTPpage> {
       
List<TextEditingController> controler = List.generate(6, (index) => TextEditingController());


Future<void> OTPvarification() async {
  try {
    String smsCode = controler.fold<String>('', (prev, controller) => prev + controller.text);
    PhoneAuthCredential credentials = PhoneAuthProvider.credential(
      verificationId: widget.VarificationId, 
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credentials);
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateYourProfilePage()));
  } catch (e) {
    print("OTP verification failed: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(
        title: Text("Enter your phone Number",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],  leading: GestureDetector(
          onTap: () { 
         Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
        ),
        backgroundColor:Colors.black87,
         body:SingleChildScrollView(
           child: Column(
             children: [
               Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50,left: 55),
                  child: Row(
                    children: List.generate(6, (index) => Container(
                         width: 40, 
                  margin: EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          textAlign: TextAlign.center,
                          maxLength: 1, 
                          controller: controler[index],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration( 
                            counterText: "", 
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 0.5 , 
                                color: Colors.white
                              )
                            )                     
                           ),
                           style: TextStyle(color: Colors.white),
                             onChanged: (value) {
                      if (value.isNotEmpty && index < controler.length - 1) {
                        FocusScope.of(context).nextFocus(); // Move to the next TextField
                      }
                    },
                    ),      
                    )
                   )
                  ),
                ),
               ),
              SizedBox(height: 480,),
                 Container(
                  height: 30, 
                  width: 150, 
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                      color: Color.fromARGB(197, 29, 239, 197), 
                      borderRadius: BorderRadius.all(Radius.circular(3))
                  ),
                child: GestureDetector(
                  onTap: () { 
                   OTPvarification();
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => CreateYourProfilePage()));
                  },
                  child: Text("Next",style: TextStyle(fontWeight: FontWeight.bold),)),
                )
             ],
           ),
         )
      
    );
  }
}