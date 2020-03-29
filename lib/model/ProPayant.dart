import 'package:social_app/model/Categorie.dart';
import 'package:social_app/model/Professionnel.dart';

class ProPayant extends Professionnel {
  Categorie categorie;
  DateTime dateExperiation;
  
  
  ProPayant({
    this.categorie,
    this.dateExperiation,
  });
  
}
