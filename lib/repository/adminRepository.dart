import 'package:social_app/model/Admin.dart';





abstract class AdminRepository{
  Future<int> createAdmin(Admin admin);
  Future<int> updateAdmin(Admin admin);
  Future<int> deleteAdmin(String id); 
  Future<bool> exists(String id);
}