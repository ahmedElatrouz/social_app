import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Talent.dart';
import 'package:image/image.dart' as Im;
import 'talentRepository.dart';

final StorageReference storageRef = FirebaseStorage.instance.ref();
final FirebaseAuth _auth = FirebaseAuth.instance;
final usersRef = Firestore.instance.collection("Talents");

class TalentRepositoryImpl implements TalentRepository {
  
  String uid = '';

  @override
  Future<int> createTalent(Talent talent) async {
    int r = 0;
    try {
      await usersRef.add(talent.toMap());
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateTalent(Talent talent) async {
    int r = 0;
    try {
      if (await exists(talent.uid) == true) {
        await usersRef.document(talent.uid).updateData(talent.toMap());
        _auth.currentUser().then((resultUser) async {
          await resultUser.updateEmail(talent.email);
          await resultUser.updatePassword(talent.password);
        });

        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteTalent(String id) async {
    int r = 0;
    try {
      if (await exists(id) == true) {
        await usersRef.document(id).delete();
        r = 1;
      }
      
      
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<bool> exists(String id)async{
      final doc= await usersRef.document(id).get();
      if(!doc.exists){
        return false;
      }
      return true;
  }

  @override
  Future<List<Talent>> searchByName(String name)async{

    List<Talent> talents=[];
    try{
        var users=await usersRef.where("nom",isGreaterThanOrEqualTo: name).getDocuments();
        talents=users.documents.map((doc)=>Talent.fromMap(doc.data)).toList();
    }catch(e){
      print(e);
    }
    return talents;
  }

  @override
  Future<List<Talent>> allTalents() async {
    List<Talent> talents = [];
    try {
      var users = await usersRef.getDocuments();
      talents = users.documents.map((doc) => Talent.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return talents;
  }

  @override
  Future<List<Talent>> searchByCategorie(Categorie categorie) async {
    List<Talent> talents = [];
    try {
      var users = await usersRef
          .where("categorie_ID", isEqualTo: categorie.catID)
          .getDocuments();

      talents = users.documents.map((doc) => Talent.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return talents;
  }

  Future<String> getcurrentUserUid() async {
    return (await _auth.currentUser()).uid;
  }

  @override
  Future<Talent> getCurrentTalent() async {
    Talent talent;
    FirebaseUser user = await _auth.currentUser();
    try {
      var doc = await usersRef.document(user.uid).get();
      talent = Talent.fromMap(doc.data);
      return talent;
    } catch (e) {
      print(e);
      return null;
    }
    
  }


  @override
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Talent _talentFromFirebaseUser(FirebaseUser user) {
    return user != null ? Talent(uid: user.uid) : null;
  }


  @override
  Future<Talent> searchById(String id) async {
    Talent talent;
    try {
      var user = await usersRef.document(id).get();
      talent = Talent.fromMap(user.data);
    } catch (e) {
      print(e);
    }

    return talent;
  }

  //profile pic************************************************

  handleSubmitProfileImage(image, currentTalentUid) async {
    await compressImage(image, currentTalentUid);
    String mediaUrl =
        await this.uploadImage(imageFile: image, talentId: currentTalentUid);
    createPostInFirestore(
      mediaUrl: mediaUrl,
      currentTalentUid: currentTalentUid,
    );
  }

  createPostInFirestore({String mediaUrl, String currentTalentUid}) async {
    try {
      await usersRef
          .document(currentTalentUid)
          .updateData({'photoProfile': mediaUrl});
    } catch (e) {
      print(e);
    }
  }

  compressImage(image, currentTalentUid) async {
    final temDir = await getTemporaryDirectory();
    final path = temDir.path;
    Im.Image imageFile = Im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$currentTalentUid.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    image = compressedImageFile;
  }

  Future<String> uploadImage({File imageFile, String talentId}) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$talentId.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      return downloadUrl;
    }
    return null;
  }

  @override
  Future<List<Talent>> searchByIsValidated(bool isValidated) async {
     List<Talent> talents=[];
    try{
        var users=await usersRef.where("isValidated",isEqualTo: isValidated).getDocuments();
        talents=users.documents.map((doc)=>Talent.fromMap(doc.data)).toList();
    }catch(e){
      print(e);
    }
    return talents;
  }
}
