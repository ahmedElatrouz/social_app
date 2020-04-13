


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/postRepository.dart';

class PostRepositoryImpl implements PostRepository {

  final postsRef=Firestore.instance.collection("posts");  




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
}