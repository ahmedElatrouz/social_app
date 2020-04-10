

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/view/accueil/actualite_page.dart';

final usersRef=Firestore.instance.collection("Talents");


class TalentDao  {
  

  void createTalent(Talent talent)async {
    try{
        await usersRef.add(talent.toMap());
    }catch(e){
      print(e);
    }
    
  }

  updateTalent(Talent talent)async{
    
    try{
      if(exists(talent.uid)==true)
    await usersRef.document(talent.uid).updateData(talent.toMap());
    }catch(e){
      print(e);
    }
  
  }


  deleteTalent(String id)async{
      try{
    await usersRef.document(id).delete();
    }catch(e){
      print(e);
    }
  }


  Future<bool> exists(String id)async{
      final doc= await usersRef.document(id).get();
      if(!doc.exists){
        return false;
      }
      return true;
  }

  Future<List<Talent>> searchByName(String name)async{

    List<Talent> talents=null;
    try{
        var users=await usersRef.where("nom",isGreaterThanOrEqualTo: name).getDocuments();
        talents=users.documents.map((doc)=>Talent.fromMap(doc.data)).toList();
    }catch(e){
      print(e);
    }
   


   return talents;
  }


  




}