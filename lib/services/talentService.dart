
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/talentRepository.dart';
import 'package:social_app/repository/talentRepositoryImpl.dart';

class TalentService  {

  TalentRepository talentRepository;
  
  
  TalentService(){
    talentRepository=TalentRepositoryImpl();
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

  Future<Talent> getCurrentUser(){
     return talentRepository.getCurrentTalent();

  }

  Future signIn(String email,String password){
    dynamic result=talentRepository.signIn(email, password);
    return result;
  }


  

}
