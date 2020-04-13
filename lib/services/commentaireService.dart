import 'package:social_app/model/Commentaire.dart';
import 'package:social_app/repository/commentaireRepository.dart';
import 'package:social_app/repository/commentaireRepositoryImpl.dart';

class CommentaireService {
  CommentaireRepository commentaireRepository;

  CommentaireService() {
    commentaireRepository = CommentaireRepositoryImpl();
  }

  Future<int> createCommentaire(Commentaire commentaire) {
    return commentaireRepository.createCommentaire(commentaire);
  }

  Future<int> updateCommentaire(Commentaire commentaire) {
    return commentaireRepository.updateCommentaire(commentaire);
  }

  Future<int> deleteCommentaire(String id) {
    return commentaireRepository.deleteCommentaire(id);
  }
}
