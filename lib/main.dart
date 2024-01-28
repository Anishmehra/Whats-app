import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watsapppp/Authenticationpage/FrontPage.dart';
import 'package:watsapppp/CreaateProfilePage/auth_controler.dart';
import 'package:watsapppp/Watapppages/HeaderPage.dart';


Future<void>main() async{
WidgetsFlutterBinding.ensureInitialized(); 
  try {
    await Firebase.initializeApp(); 
  } catch (e) {
    print("Firenase initializeError $e"); 
  }
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Scaffold(
          body: ref.watch(userDataAuthProvider).when(
            data:(user) {
              if(user == null) 
              {
                return const FrontPage();
              }
              return  headerPage();
            } , 
          error: (err, trece){
            return Text(err.toString());
          }, 
          loading: () => CircularProgressIndicator()
          )

    )
    );
  }
}


