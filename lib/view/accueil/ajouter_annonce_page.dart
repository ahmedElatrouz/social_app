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
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              
              Container(
                
                margin: EdgeInsets.all(15),
                child: TextField(
                  cursorColor: Colors.purple,
                  decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                      focusColor: Colors.black,
                      fillColor: Colors.black,
                      hoverColor: Colors.black,
                      hintText: 'titre',
                      hintStyle: TextStyle(color: Colors.black38),
                      icon: Icon(
                        Icons.title,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                      border: UnderlineInputBorder()),
                ),
              ),
              Container(
                child: TextField(
                   cursorColor: Colors.purple,
                decoration: InputDecoration(
                  
                  focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple)),
                  hintText: 'Entrez votre annonce ici',
                  border: OutlineInputBorder()),
                  
                maxLines: 10,
                )
                
              ),
              SizedBox(
                height:20,
              ),

              Container(
                height: 50,
                width: 120,
                child: RaisedButton(
                  
                  child: Text('Publier'),
                  color: Colors.purple,
                  onPressed: ()=>print("pressed"),
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
