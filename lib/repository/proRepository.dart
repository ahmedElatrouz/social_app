

import 'package:social_app/model/Professionnel.dart';

abstract class ProfessionelRepository{
  Future<int> createProfessionel(Professionnel pro);
  Future<int> updateProfetionnel(Professionnel pro);
  Future<int> deleteProfetionnel(String id);
}