

import 'package:social_app/model/Categorie.dart';

import 'Utilisateur.dart';

class Talent extends Utilisateur {
  int id=1;
  Categorie categorie ;
  String photo="sdl";
  String video="sdl";
  String description="sdl";
  String posts;
  Talent({
    this.id=1,
    this.categorie,
    this.photo="sdl",
    this.video="sdl",
    this.description="sdl",
    this.posts,
  });

  


 }
