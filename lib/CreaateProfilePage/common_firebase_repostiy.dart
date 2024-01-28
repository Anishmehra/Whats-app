// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final commonFirebaseRepositry = Provider((ref) => commonFirebaseStroage(firebasestorage: FirebaseStorage.instance));

class commonFirebaseStroage {
  final FirebaseStorage firebasestorage;
  commonFirebaseStroage({
    required this.firebasestorage,
  });
 
  Future<String> storefiletostorage (String ref,File file) async{
    UploadTask uploadTask = firebasestorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String dowloadurl = await snap.ref.getDownloadURL();
    return dowloadurl;
  }
}
