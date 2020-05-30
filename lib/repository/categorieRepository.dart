



import 'package:social_app/model/Categorie.dart';

abstract class CategorieRepository {
  Future<int> createCategorie(Categorie categorie);
  Future<int> updateCategorie(Categorie categorie);
  Future<int> deleteCategorie(String id);
  Future<List<Categorie>> searchByName(String name);
  Future<List<Categorie>> allCategories();
  Future<Categorie> getCategory(String name);
  Future<String> handleSubmitImage(image, categoryId);
}