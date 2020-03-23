  enum Genre{
    homme,femme
  }

class Utilisateur {
  String nom;
  String prenom;
  Genre genre;
  int age;
  String login;
  String password;
  String email;
  String tel;
  String nationalite;


  Utilisateur({
    this.nom,
    this.prenom,
    this.genre,
    this.age,
    this.login,
    this.password,
    this.email,
    this.tel,
    this.nationalite,
  });
  


}
