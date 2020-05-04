
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Talent.dart';

abstract class TalentRepository {
  Future<int> signIn(String email, String password);
  Future<int> createTalent(Talent talent);
  Future<int> updateTalent(Talent talent);
  Future<int> deleteTalent(String id);
  Future<List<Talent>> searchByName(String name);
    Future<Talent> searchById(String id);

  Future<List<Talent>> searchByCategorie(Categorie categorie);
  Future<Talent> getCurrentTalent();
  Future signOut();
  Future<List<Talent>> allTalents();
  handleSubmitProfileImage(image , currentTalentUid);
}