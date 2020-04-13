import 'package:social_app/model/Annonce.dart';
import 'package:social_app/repository/annonceRepository.dart';
import 'package:social_app/repository/annonceRepositoryImpl.dart';

class AnnoonceService {
  AnnonceRepository annonceRepository;

  AnnoonceService() {
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
}
