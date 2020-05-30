import 'dart:convert';

class Categorie {
  String catID;
  String cat;
  String description;
  String imageUrl;
  
  Categorie({
    this.catID,
    this.cat,
    this.description,
    this.imageUrl,
  });

 


  Map<String, dynamic> toMap() {
     if (this==null) return {};
    return {
      'catID': catID,
      'cat': cat,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static Categorie fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Categorie(
      catID: map['catID'],
      cat: map['cat'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Categorie fromJson(String source) => fromMap(json.decode(source));
  }
