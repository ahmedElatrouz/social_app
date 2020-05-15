import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/repository/annonceRepository.dart';
import 'package:social_app/repository/proRepositoryImpl.dart';
import 'package:uuid/uuid.dart';

final annRef = Firestore.instance.collection('Annonces');

class AnnonceRepositoryImpl implements AnnonceRepository {
  String annonceId = Uuid().v4();
  @override
  Future<int> createAnnonce(Annonce annonce) async {
    int r = 0;
    try {
      annonce.id= annonceId;
      await annRef.document(annonceId).setData({
        'uid': annonceId,
        'date': annonce.date,
        'description': annonce.description,
        'proRef': annonce.proRef,
        'comments': {},
      });
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> updateAnnonce(Annonce annonce) async {
    int r = 0;
    var doc = await userRef.document(annonce.id).get();
    try {
      if (doc.exists) {
        doc.reference.updateData(annonce.toMap());
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteAnnonce(String id) async {
    int r = 0;
    var doc = await userRef.document(id).get();
    try {
      if (doc.exists) {
        doc.reference.delete();
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<List<Annonce>> searchByUser(String id) async {
    //if (await ProfessionelService().exists(id) == false) return null;
    List<Annonce> annonces = [];
    try {
      var snapshot = await annRef.where("proRef", isEqualTo: id).getDocuments();
      annonces =
          snapshot.documents.map((doc) => Annonce.fromMap(doc.data)).toList();
    } catch (e) {
      print(e);
    }
    return annonces;
  }

  @override
  Future<List<Annonce>> allAnnonces() async {
    List<Annonce> annonces = [];
    try {
      var snapshot =
          await annRef.orderBy('date', descending: true).getDocuments();
      annonces =
          snapshot.documents.map((doc) => Annonce.fromMap(doc.data)).toList();
      print(annonces.length);
    } catch (e) {
      print(e);
      return null;
    }
    return annonces;
  }
}
