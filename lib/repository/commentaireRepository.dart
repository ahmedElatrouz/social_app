import 'package:social_app/model/Commentaire.dart';

abstract class CommentaireRepository {
  Future<int> createCommentaire(Commentaire commentaire);
  Future<int> updateCommentaire(Commentaire commentaire);
  Future<int> deleteCommentaire(String id);
}
