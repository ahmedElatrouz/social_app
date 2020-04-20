import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/postRepository.dart';

class PostRepositoryImpl implements PostRepository {

  final postsRef=Firestore.instance.collection("Posts");  
  final postRef = Firestore.instance.collection('Posts');
  final StorageReference storageRef = FirebaseStorage.instance.ref();


  @override
  Future<int> createPost(Post post)async{
    int r=0;
    try{
        await postsRef.add(post.toMap());
        r=1;
    }catch(e){
      print(e);
    }
    return r;
  }



  @override
  Future<int> updatePost(Post post)async{
     int r=0;
    try{
      if(await exists(post.postID)==true){
        await postsRef.document(post.postID).updateData(post.toMap());
        r=1;
      }
    }catch(e){
      print(e);
    }
  return r;
  }



  @override
  Future<int> deletePost(String id)async{
     int r=0;
    try{
      if(await exists(id)==true){
        await postsRef.document(id).delete();
        r=1;
      }
    }catch(e){
      print(e);
    }
  return r;


  }


  @override
  Future<List<Post>> searchByUser(Talent talent)async{
    if(await exists(talent.uid)==false) return null;
    List<Post> posts=[];
    try{
        var result=await postsRef.where("talent_ID",isEqualTo: talent.uid).getDocuments();
    posts=result.documents.map((doc)=>Post.fromMap(doc.data)).toList();

    }catch(e){
      print(e);
    }
    return posts;

  }




    Future<bool> exists(String id)async{
      final doc= await postsRef.document(id).get();
      if(!doc.exists){
        return false;
      }
      return true;
  }

  @override
  createPostInFirestore({String mediaUrl, String description,String talentId,String postId}) {
    postRef.document(postId).setData({
      "date" : new DateTime.now(),
      "description" : description,
      "nombreLikes" : {},
      "photoUrl" : mediaUrl,
      "talent_ID" : talentId,
      "videoUrl" : '',
    });
  }

  @override
  Future<String> uploadImage(imageFile,postId) async{
    StorageUploadTask uploadTask = storageRef.child('post_$postId.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String doawnloadUrl = await storageSnap.ref.getDownloadURL();
    print(doawnloadUrl);
    return doawnloadUrl;
  }
}