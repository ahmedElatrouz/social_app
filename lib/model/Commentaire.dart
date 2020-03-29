
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Talent.dart';

class Commentaire {
  String contenue;
  DateTime date;
  Talent talent;
  Annonce annonce;
 
  Commentaire({
    this.contenue,
    this.date,
    this.talent,
    this.annonce,
  });
}
