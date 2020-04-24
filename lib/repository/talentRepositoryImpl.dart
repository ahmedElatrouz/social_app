

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Talent.dart';

import 'talentRepository.dart';
//import 'package:social_app/view/accueil/actualite_page.dart';



class TalentRepositoryImpl implements TalentRepository  {
  final usersRef=Firestore.instance.collection("Talents");
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = '';

  @override
  Future<int> createTalent(Talent talent)async {
    int r=0;
    try{
        await usersRef.add(talent.toMap());
        r=1;
    }catch(e){
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateTalent(Talent talent)async{
    int r=0;
    try{
      if(await exists(talent.uid)==true){
        await usersRef.document(talent.uid).updateData(talent.toMap());
        r=1;
      }
    }catch(e){
      print(e);
    }
  return r;
  }

  @override
  Future<int> deleteTalent(String id)async{
    int r=0;
      try{
        if(await exists(id)==true){
    await usersRef.document(id).delete();
    r=1;
        }
    }catch(e){
      print(e);
    }
    return r;
  }

  
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
        var users=await usersRef.where("nom",isEqualTo: name).getDocuments();
        talents=users.documents.map((doc)=>Talent.fromMap(doc.data)).toList();
    }catch(e){
      print(e);
    }
   return talents;
  }

  @override
  Future<List<Talent>> searchByCategorie(Categorie categorie)async {
    List<Talent> talents=[];
    try{
        var users=await usersRef.where("categorie_ID",isEqualTo: categorie.catID).getDocuments();
        
        talents=users.documents.map((doc)=>Talent.fromMap(doc.data)).toList();
    }catch(e){
      print(e);
    }
   return talents;
  
  }



  Future<String> getcurrentUserUid() async {
    
  return (await auth.currentUser()).uid;
  } 


   


  @override
  Future<Talent> getCurrentTalent() async{
    
    Talent talent;
    FirebaseUser user = await auth.currentUser();
   
    try{
      var doc = await usersRef.document(user.uid).get();
          talent =Talent.fromMap(doc.data);
    }catch(e){
      print(e);
    }
    return talent;
  }




  @override
  Future signIn(String email, String password) async{
    dynamic result;
    FirebaseUser user;
    try{
       result=await auth.signInWithEmailAndPassword(email: email, password: password);
        user = result.user;
      
       
    }catch(e){
      print(e);
    }
    return _talentFromFirebaseUser(user);
  }

    Talent _talentFromFirebaseUser(FirebaseUser user) {
    return user != null ? Talent(uid: user.uid) : null;
  }

}