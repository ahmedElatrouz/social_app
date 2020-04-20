import 'dart:io';

import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
 
abstract class PostRepository {
  Future<int> createPost(Post post);
  Future<int> updatePost(Post post);
  Future<int> deletePost(String id);
  Future<List<Post>> searchByUser(Talent talent);
  Future<String> uploadImage(imageFile,postId);
  createPostInFirestore({String mediaUrl,String description,String talentId,String postId});
}