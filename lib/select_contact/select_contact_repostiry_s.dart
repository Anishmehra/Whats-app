import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:watsapppp/CreaateProfilePage/user_models.dart';

class SelectContactRepositry{
  final FirebaseFirestore firestore; 
  final FirebaseAuth auth;

  SelectContactRepositry({
    required this.firestore, 
    required this.auth
    });
    
   Future<userModel?> getCurrentUserDate() async{

          var UserData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
 userModel? user;
          if(UserData.data() != null){
            user = userModel.fromMap(UserData.data()!);
          }
          return user;
  }

}