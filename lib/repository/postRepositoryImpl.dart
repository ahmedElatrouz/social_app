import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/postRepository.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final postRef = Firestore.instance.collection('Posts');
final StorageReference storageRef = FirebaseStorage.instance.ref();

class PostRepositoryImpl implements PostRepository {
  String postId = Uuid().v4();
 
  @override
  Future<int> createPost(Post post) async {
    int r = 0;
    try {
      await postRef.document(postId).setData(post.toMap());
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> updatePost(Post post) async {
    int r = 0;
    try {
      if (await exists(post.postId) == true) {
        await postRef.document(post.postId).updateData(post.toMap());
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deletePost(String id) async {
    int r = 0;
    try {
      if (await exists(id) == true) {
        await postRef.document(id).delete();
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<List<Post>> searchByUser(Talent talent) async {
    if (await exists(talent.uid) == false) return null;
    List<Post> posts = [];
    try {
      var result = await postRef
          .where("talent_ID", isEqualTo: talent.uid)
          .getDocuments();
      posts = result.documents.map((doc) => Post.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return posts;
  }

  Future<bool> exists(String id) async {
    final doc = await postRef.document(id).get();
    if (!doc.exists) {
      return false;
    }
    return true;
  }


  /// Upload image to firestore  ***************************************
  @override
  handleSubmitImage(image, captionController, currentTalentUid) async {
    await compressImage(image);

    String mediaUrl = await 
        this.uploadImage(imageFile: image, postId: postId);

    createPostInFirestore(
      mediaUrl: mediaUrl,
      description: captionController.text,
      currentTalentUid: currentTalentUid,
    );
  }

  compressImage(image) async {
    final temDir = await getTemporaryDirectory();
    final path = temDir.path;
    Im.Image imageFile = Im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    image = compressedImageFile;
  }

  Future<String> uploadImage({File imageFile, String postId}) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$postId.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      return downloadUrl;
    }
    return null;
  }

  createPostInFirestore(
      {String mediaUrl, String description, String currentTalentUid}) async {
    await this.createPost(Post(
      postId: postId,
      likes: {},
      date: new Timestamp.now(),
      description: description,
      photoUrl: mediaUrl,
      videoUrl: '',
      talentId: currentTalentUid,
    ));
  }

  /// Upload video to firestore  ***************************************
  @override
  handleSubmitVideo(video, captionController, currentTalentUid) async {
    await compressImage(video);

    String mediaUrl = await PostRepositoryImpl()
        .uploadVideo(videoFile: video, postId: postId);

    createPostInFirestore(
      mediaUrl: mediaUrl,
      description: captionController.text,
      currentTalentUid: currentTalentUid,
    );
  }

  Future<String> uploadVideo({File videoFile, String postId}) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$postId.jpg').putFile(videoFile);

    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();

    if (uploadTask.isComplete) {
      return downloadUrl;
    }
    return null;
  }

  ///displaying posts in profil page
  Future<List<Post>> getProfilPosts(talentId, postCount) async {
    List<Post> posts = [];
    try {
      var snapshot = await postRef
          .where("talent_ID", isEqualTo: talentId)
          //.orderBy("date", descending: true)
          .getDocuments();
      postCount = snapshot.documents.length;
      posts = snapshot.documents.map((doc) => Post.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
      return null;
    }
    return posts;
  }

  //allPosts
  @override
  Future<List<Post>> getallPosts() async {
    List<Post> posts = [];
    try {
      var snapshot =
          await postRef.orderBy("date", descending: true).getDocuments();
      posts = snapshot.documents.map((doc) => Post.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
      return null;
    }
    return posts;
  }

  //liking posts
  @override
  likePosts(currentUserId, postId, bool like) async {
    try {
      await postRef.document(postId).updateData({'likes.$currentUserId': like});
    } catch (e) {
      print(e);
      print("problem here");
    }
  }
}
