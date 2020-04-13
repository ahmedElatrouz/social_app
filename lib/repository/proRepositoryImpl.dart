import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/repository/proRepository.dart';


final userRef=Firestore.instance.collection('professionel');



class ProfessionelRepositoryImpl implements ProfessionelRepository{



  @override
  Future<int> createProfessionel(Professionnel pro) async{
    int r=0;
    try{
      await userRef.add(pro.toMap());
      r=1;
    }catch(e){
      print(e);
    }
    return r;
  }


  @override
  Future<int> updateProfetionnel(Professionnel pro) async{
    int r=0;
    var doc = await userRef.document(pro.proID).get();
    try{
      if(doc.exists){
        doc.reference.updateData(pro.toMap());
        r=1;
      }
    }catch(e){
      print(e);
    }
    return r;
  }


    @override
  Future<int> deleteProfetionnel(String id) async{
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