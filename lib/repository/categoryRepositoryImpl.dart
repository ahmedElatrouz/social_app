import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/repository/categorieRepository.dart';

final catsRef = Firestore.instance.collection("Categories");

class CategorieRepositoryImpl implements CategorieRepository {
  @override
  Future<int> createCategorie(Categorie categorie) async {
    int r = 0;
    try {
      await catsRef.add(categorie.toMap());
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
    var result =
        await catsRef.where("cat", isEqualTo: name).getDocuments();
    categorie =
        result.documents.map((doc) => Categorie.fromMap(doc.data)).single;
        print(categorie);
  } catch (e) {
    print(e);
  }
  return categorie;
}
}


