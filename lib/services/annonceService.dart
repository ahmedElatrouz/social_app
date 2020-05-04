import 'package:social_app/model/Annonce.dart';
import 'package:social_app/repository/annonceRepository.dart';
import 'package:social_app/repository/annonceRepositoryImpl.dart';

class AnnonceService {
  AnnonceRepository annonceRepository;

  AnnonceService() {
    annonceRepository = AnnonceRepositoryImpl();
  }

  Future<int> createAnnonce(Annonce annonce) {
    return annonceRepository.createAnnonce(annonce);
  }

  Future<int> updateAnnonce(Annonce annonce) {
    return annonceRepository.updateAnnonce(annonce);
  }

  Future<int> deleteAnnonce(String id) {
    return annonceRepository.deleteAnnonce(id);
  }

  Future<List<Annonce>> searchByUser(String id){
    return annonceRepository.searchByUser(id);
  }

  Future<List<Annonce>> getAnnoncesByPro(String id){
    return annonceRepository.searchByUser(id);
  }
}
