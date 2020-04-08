import 'dart:convert';

class Categorie {
  int catID;
  String cat;
  String description;
  
  Categorie({
    this.catID,
    this.cat,
    this.description,
  });

 


  Map<String, dynamic> toMap() {
    return {
      'catID': catID,
      'cat': cat,
      'description': description,
    };
  }

  static Categorie fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Categorie(
      catID: map['catID'],
      cat: map['cat'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  static Categorie fromJson(String source) => fromMap(json.decode(source));
  }
