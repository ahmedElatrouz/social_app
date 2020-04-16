
import '../profil/edit_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kHeaderTextStyle=TextStyle(
  color: Colors.white,
  fontSize: 40.0,
  fontFamily: 'Signatra',
);


 const Map<settings,List<String>> kEditElementsText={
   settings.editEmail:["Adresse e-mail","Modifier l'adresse e-mail de votre compte"],
   settings.editTel:["Numéro de téléphone","Modifier l'adresse e-mail de votre compte"],
   settings.editPassword:["Mot de passe","Modifier l'adresse e-mail de votre compte"],
   settings.accesPrive:["Visibilité de vos informations","Modifier la  visibilité de votre profil etde vos informations personnelles"],
 };