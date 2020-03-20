  enum Genre{
    homme,femme
  }

class User {
  int id;
  String nom;
  String prenom;
  Genre genre;

  int age;
  User({
    this.id,
    this.nom,
    this.prenom,
    this.genre,
    this.age,
  });
}
