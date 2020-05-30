
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/repository/categorieRepository.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;
final StorageReference storageRef = FirebaseStorage.instance.ref();
final catsRef = Firestore.instance.collection("Categories");

class CategorieRepositoryImpl implements CategorieRepository {
  String catId = Uuid().v4();
  @override
  Future<int> createCategorie(Categorie categorie) async {
    int r = 0;
    try {
      await catsRef.document(catId).setData({
        'catID': catId,
        'cat': categorie.cat,
        'description': categorie.description,
        'imageUrl': categorie.imageUrl,
      }); 
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateCategorie(Categorie categorie) async {
    int r = 0;
    try {
      if (await exists(categorie.catID) == true) {
        await catsRef.document(categorie.catID).updateData(categorie.toMap());
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteCategorie(String id) async {
    int r = 0;
    try {
      if (await exists(id) == true) {
        await catsRef.document(id).delete();
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  Future<bool> exists(String id) async {
    final doc = await catsRef.document(id).get();
    if (!doc.exists) {
      return false;
    }
    return true;
  }

  @override
  Future<List<Categorie>> searchByName(String name) async {
    List<Categorie> categories = [];

    try {
      var result =
          await catsRef.where("cat", isLessThanOrEqualTo: name).getDocuments();
      categories =
          result.documents.map((doc) => Categorie.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return categories;
  }

  @override
  Future<List<Categorie>> allCategories() async {
    List<Categorie> categories = [];
    try {
      var result = await catsRef.getDocuments();
      categories =
          result.documents.map((doc) => Categorie.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return categories;
  }

  @override
  Future<Categorie> getCategory(String name) async {
    Categorie categorie;
    try {
      var result = await catsRef.where("cat", isEqualTo: name).getDocuments();
      categorie =
          result.documents.map((doc) => Categorie.fromMap(doc.data)).single;
      print(categorie);
    } catch (e) {
      print(e);
    }
    return categorie;
  }


  /// Upload image to firestore  ***************************************
@override
Future<String> handleSubmitImage(image, categoryId) async {
    await compressImage(image, categoryId);
    String mediaUrl =
        await this.uploadImage(imageFile: image, categoryId: categoryId);
  return mediaUrl;
}
compressImage(image,categoryId) async {
    final temDir = await getTemporaryDirectory();
    final path = temDir.path;
    Im.Image imageFile = Im.decodeImage(image.readAsBytesSync());
    final compressedImageFile = File('$path/img_$categoryId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    image = compressedImageFile;
}
Future<String> uploadImage({File imageFile, String categoryId}) async {
    StorageUploadTask uploadTask =
        storageRef.child('post_$categoryId.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    if (uploadTask.isComplete) {
      return downloadUrl;
    }
    return null;
}

}
