import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/repository/annonceRepository.dart';
import 'package:social_app/repository/proRepositoryImpl.dart';




final annRef=Firestore.instance.collection('Annonces');

class AnnonceRepositoryImpl implements AnnonceRepository{

  @override
  Future<int> createAnnonce(Annonce annonce) async{
    int r=0;
    try{
      await annRef.add(annonce.toMap());
      r=1;
    }catch(e){
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateAnnonce(Annonce annonce) async{
    int r=0;
    var doc =await userRef.document(annonce.id).get();
    try{
      if(doc.exists){
        doc.reference.updateData(annonce.toMap());
        r=1;
      }
    }catch(e){
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteAnnonce(String id) async{
    int r=0;
    var doc =await userRef.document(id).get();
    try{
      if(doc.exists){
        doc.reference.delete();
        r=1;
      }
    }catch(e){
      print(e);
    }
    return r;
  }


}