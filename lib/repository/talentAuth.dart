import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Talent.dart';
import 'package:image/image.dart' as Im;
final _authStore = Firestore.instance.collection('Talents');
final FirebaseAuth _auth = FirebaseAuth.instance;
final StorageReference storageRef = FirebaseStorage.instance.ref();

class TalentAuth { 

 
  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }

  Future<String> getcurrentUserUid() async {
    return (await _auth.currentUser()).uid;
  }


  Talent _talentFromFirebaseUser(FirebaseUser talent) {
    return talent != null ? Talent(uid: talent.uid) : null;
  }

  Stream<Talent> get talent {
    return _auth.onAuthStateChanged.map(_talentFromFirebaseUser);
  }




  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser talent = result.user;
      return _talentFromFirebaseUser(talent);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

 

  Future createDocumment(
      String age,
      String email,
      String genre,
      String natonalite,
      String nom,
      String password,
      String prenom,
      String tel,
      String photoUrl,
      String videoUrl,
      String description,
      Categorie category) async {
        
    FirebaseUser user = await _auth.currentUser();
    print(email +' '+ password);
    DocumentSnapshot doc = await _authStore.document(user.uid).get();
    if (!doc.exists) {
      try {
        await _authStore.document(user.uid).setData({
          "uid": user.uid,
          "age": age,
          "email": email,
          "genre": genre,
          "nationalite": natonalite,
          "nom": nom,
          "password": password,
          "prenom": prenom,
          "tel": tel,
          "photoUrl": photoUrl,
          "videoUrl": videoUrl,
          "photoProfile": '',
          "description": description,
          "Categorie" : category.toMap(),
        });
        doc = await _authStore.document(user.uid).get();
        return doc;
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
  } 




  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser talent = result.user;
      return _talentFromFirebaseUser(talent);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }



  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }






  // first post ***
 Future<String>   handleSubmitFirstPost(image, nom) async {
    await compressImage(image, nom);
    String mediaUrl =
        await this.uploadImage(imageFile: image, nom: nom);

  return mediaUrl;
  }


  compressImage(image, nom) async {
    final temDir = await getTemporaryDirectory();
    final path = temDir.path;
    Im.Image imageFile = Im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$nom.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    image = compressedImageFile;
  }

  Future<String> uploadImage({File imageFile, String nom}) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$nom.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      return downloadUrl;
    }
    return null;
  }
}


