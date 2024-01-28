
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watsapppp/Authenticationpage/OTPpage.dart';


class NumberValidationPage extends StatefulWidget {
  NumberValidationPage({Key? key}) : super(key: key);

  @override
  State<NumberValidationPage> createState() => _NumberValidationPageState();
}

class _NumberValidationPageState extends State<NumberValidationPage> {
  TextEditingController phoneNumber = TextEditingController();
  FirebaseAuth authentication = FirebaseAuth.instance;


  Future<void> otpValidationPage(BuildContext context) async {
    try {
      await authentication.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        
        verificationFailed: (FirebaseAuthException ex) {},
        timeout: Duration(seconds: 60),
        codeSent: (String verificationId, int? resend) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPpage(VarificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: phoneNumber.text.toString(),
      );
    } catch (e) {
      print("otp send faield $e");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text(
          "Enter your phone Number",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
        leading: GestureDetector(
          onTap: () {
            
         Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,color: Colors.white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 23, top: 20),
              child: Row(
                children: [
                  Text(
                    "WhatUp Will need to verify your phone number.",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    child: Text("What's", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Text(" my number?", style: TextStyle(color: Colors.blue)),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: phoneNumber,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(2)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 400),
            Container(
              height: 30,
              width: 150,
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: Color.fromARGB(197, 29, 239, 197),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: GestureDetector(
                onTap: () {
                 otpValidationPage(context);
            //       /Navigator.push(
            // context,
            // MaterialPageRoute(
            //   builder: (context) => OTPpage(),
            // ),
            // );
                },
                child: Text("Next", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
