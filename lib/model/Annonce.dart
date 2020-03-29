import 'package:social_app/model/Professionnel.dart';

class Annonce {
  int id;
  DateTime date;
  String description;
  Professionnel pro;
  
  
  Annonce({
    this.id,
    this.date,
    this.description,
    this.pro,
  });
}
