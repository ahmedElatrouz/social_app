import 'package:social_app/model/Annonce.dart';




abstract class AnnonceRepository{
   Future<int> createAnnonce(Annonce annonce);
   Future<int> updateAnnonce(Annonce annonce);
   Future<int> deleteAnnonce(String id); 
   Future<List<Annonce>> searchByUser(String id);
}