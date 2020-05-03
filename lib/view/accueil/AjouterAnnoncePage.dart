import 'package:flutter/material.dart';
import 'package:social_app/model/Professionnel.dart';

class AjouterAnnoncePage extends StatefulWidget {
  final Professionnel pro;

  const AjouterAnnoncePage({Key key, this.pro}) : super(key: key);
  @override
  _AjouterAnnoncePageState createState() => _AjouterAnnoncePageState();
}

class _AjouterAnnoncePageState extends State<AjouterAnnoncePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Column(children: <Widget>[
          
        ],),
      ),
    );
  }
}