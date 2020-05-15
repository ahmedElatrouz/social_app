

import 'package:social_app/model/Categorie.dart';
import 'package:social_app/repository/categorieRepository.dart';
import 'package:social_app/repository/categoryRepositoryImpl.dart';

class CategorieService {


  CategorieRepository categorieRepository;

  CategorieService(){
    categorieRepository=CategorieRepositoryImpl();
  }

  Future<int> createCategorie(Categorie categorie){
    return categorieRepository.createCategorie(categorie);
  }
  Future<int> updateCategorie(Categorie categorie){
      return categorieRepository.updateCategorie(categorie);
  }
  Future<int> deleteCategorie(String id){
    return categorieRepository.deleteCategorie(id);
  }
  Future<List<Categorie>> searchByName(String name){
    return categorieRepository.searchByName(name);
  }
  Future<List<Categorie>> allCategories(){
    return categorieRepository.allCategories();
  }

  Future<Categorie> getCategory(String name){
    return categorieRepository.getCategory(name);
  }
  
}