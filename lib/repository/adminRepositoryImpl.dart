

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/model/Admin.dart';
import 'package:social_app/repository/adminRepository.dart';


final userRef = Firestore.instance.collection("Admins");
final FirebaseAuth _auth = FirebaseAuth.instance;
class AdminRepositoryImpl implements AdminRepository{


  @override
  Future<int> createAdmin(Admin admin) async{
    int r=0;
    try{
      userRef.add(admin.toMap());
      r=1;
    }catch(e){
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateAdmin(Admin admin) async{ 
    int r=0;
    var doc = await userRef.document(admin.uid).get();
    try{
      if(doc.exists){
        doc.reference.updateData(admin.toMap());
        r=1;
      }
    }catch(e){
      print(e);
    }
    return r;
  }


  @override
  Future<int> deleteAdmin(String id) async{
    int r=0;
    var doc = await userRef.document(id).get();
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

 @override
  Future<bool> exists(String id)async{
      final doc= await userRef.document(id).get();
      if(!doc.exists){
        return false;
      }
      return true;
  }




  
}