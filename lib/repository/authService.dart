
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/main.dart';

import 'package:social_app/services/adminService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/constants.dart';

class AuthService {
  TalentService talentService;
  ProfessionelService professionelService;
  AdminService adminService;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService(){
    
    this.talentService=TalentService();
    this.professionelService=ProfessionelService();
    this.adminService=AdminService();
  }

  
  Future signIn(String email, String password) async {
    int result=0;
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = authResult.user;
      if(user!=null ){
        
         if(await talentService.exists(user.uid))MyApp.userType=UserType.talent;
         else if(await professionelService.exists(user.uid))MyApp.userType=UserType.professionnel;
         else if(await adminService.exists(user.uid)) MyApp.userType=UserType.admin;

         result=1;
      }
      
    } catch (e) {
      print(e);
    }
    return result;
  }
}
