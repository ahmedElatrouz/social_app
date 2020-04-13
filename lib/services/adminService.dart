import 'package:social_app/model/Admin.dart';
import 'package:social_app/repository/adminRepository.dart';
import 'package:social_app/repository/adminRepositoryImpl.dart';

class AdminService {
  AdminRepository adminRepository;

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
}
