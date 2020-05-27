import 'package:social_app/model/Admin.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/adminRepository.dart';
import 'package:social_app/repository/adminRepositoryImpl.dart';
import 'package:social_app/repository/talentRepository.dart';

class AdminService {
  AdminRepository adminRepository;
  TalentRepository talentRepository;

  AdminService() {
    adminRepository = AdminRepositoryImpl();
  }

  Future<int> createAdmin(Admin admin) {
    return adminRepository.createAdmin(admin);
  }

  Future<int> updateAdmin(Admin admin) {
    return adminRepository.updateAdmin(admin);
  }

  Future<int> deleteAdmin(String id) {
    return adminRepository.deleteAdmin(id);
  }
  Future<bool> exists(String id){
    return adminRepository.exists(id);
  }

  Future<int> validateProfil(Talent talent){
    talent.isValidated=true;
   return talentRepository.updateTalent(talent);
  }

  Future<int> deleteProfil(Talent talent){
    return talentRepository.deleteTalent(talent.uid);
  }
}
