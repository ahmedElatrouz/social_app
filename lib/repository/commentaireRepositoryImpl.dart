import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/model/Commentaire.dart';
import 'package:social_app/repository/commentaireRepository.dart';

final commentRef = Firestore.instance.collection('Commentaires');

class CommentaireRepositoryImpl implements CommentaireRepository {
  @override
  Future<int> createCommentaire(Commentaire commentaire) async {
    int r = 0;
    try {
      await commentRef.add(commentaire.toMap());
      r = 1;
    } catch (e) {
      print(e);
    }
    return r;
  }

  @override
  Future<int> deleteCommentaire(String id) async {
    int r = 0;
    var doc = await commentRef.document(id).get();
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
  Future<int> updateCommentaire(Commentaire commentaire) async {
    int r = 0;
    var doc = await commentRef.document(commentaire.uid).get();
    try {
      if (doc.exists) {
        doc.reference.updateData(commentaire.toMap());
        r = 1;
      }
    } catch (e) {
      print(e);
    }
    return r;
  }
}
