import 'package:social_app/model/Utilisateur.dart';

class Professionnel extends Utilisateur {

    int proID;
  Professionnel({
    this.proID,
  }):super();
  


}

void main() { 
   Professionnel s1 = new Professionnel(); 
   print(s1.email); 
   print(s1.proID); 
} 
