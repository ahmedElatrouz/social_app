
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Talent.dart';

abstract class TalentRepository {
  Future<dynamic> signIn(String email, String password);
  Future<int> createTalent(Talent talent);
  Future<int> updateTalent(Talent talent);
  Future<int> deleteTalent(String id);
  Future<List<Talent>> searchByName(String name);
  Future<List<Talent>> searchByCategorie(Categorie categorie);
  Future<Talent> getCurrentTalent();
  
}