import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/talentRepository.dart';
import 'package:social_app/repository/talentRepositoryImpl.dart';

class TalentService {
  TalentRepository talentRepository;

  TalentService() {
    talentRepository = TalentRepositoryImpl();
  }

  Future<int> createTalent(Talent talent) {
    return talentRepository.createTalent(talent);
  }

  Future<int> updateTalent(Talent talent) {
    return talentRepository.updateTalent(talent);
  }

  Future<int> deleteTalent(String id) {
    return talentRepository.deleteTalent(id);
  }

  Future<List<Talent>> searchByName(String name) {
    return talentRepository.searchByName(name);
  }

  Future<Talent> getCurrentUser() {
    return talentRepository.getCurrentTalent();
  }

  Future<bool> exists(String id) {
    return talentRepository.exists(id);
  }

  Future signOut() async {
    await talentRepository.signOut();
  }

  Future<Talent> searchById(String id) {
    return talentRepository.searchById(id);
  }
   Future<List<Talent>> searchByIsValidated(bool isValidated){
     return talentRepository.searchByIsValidated(isValidated);
   }

  Future<List<Talent>> allTalents() {
    return talentRepository.allTalents();
  }

  handleSubmitProfileImage(image, currentTalentUid) {
    return talentRepository.handleSubmitProfileImage(image, currentTalentUid);
  }
}
