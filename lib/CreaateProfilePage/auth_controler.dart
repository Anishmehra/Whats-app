import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapppp/CreaateProfilePage/auth_respositry.dart';
import 'package:watsapppp/CreaateProfilePage/user_models.dart';


final AuhtControllerProvider = Provider((ref) {
  final authrespositry = ref.watch(authproviderrepositry); 
  return Authcontroler(
    Authrespositry: authrespositry,
    ref: ref,
  );
});

final  userDataAuthProvider = FutureProvider((ref) {
final authController = ref.watch(AuhtControllerProvider);
return authController.getUserData();
});

class Authcontroler {
  final authrespositry Authrespositry;
  final ProviderRef ref;

  Authcontroler({
    required this.Authrespositry,
    required this.ref,
  });

Future<userModel?> getUserData() async{
    userModel? user = await Authrespositry.getCurrentUserDate();
    return user;
}

  void saveUseraDataToFirebase(BuildContext context, String name, File? profilePic) {
    Authrespositry.saveuserdate(
      name: name,
      profilePic: profilePic,
      context: context,
      ref: ref,
    );
  }
}
