import 'package:flutter/material.dart';
import 'package:social_app/model/Categorie.dart';
List<Categorie> categories=[Categorie(cat:'Music',description:'cette categorie rejoint les talents en musique')];
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:CategorieCard(categorie: categories[0],),
 
      )
    );
  }
}

class CategorieCard extends StatelessWidget {
  final Categorie categorie;

  const CategorieCard({Key key, this.categorie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
                      Radius.circular(5.0)),
                      color: Colors.white,
    ),
    
    margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
    height: 100,
    child: Row(
    children:<Widget>[
      Container(
        margin: EdgeInsets.only(right:10),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.only(topLeft:
                     Radius.circular(5.0),bottomLeft:Radius.circular(5.0) ),
          //color: Colors.black,
          image: DecorationImage(image: AssetImage('assets/images/3.jpg'),fit: BoxFit.cover,)
          
        ),
        
        
        width:MediaQuery.of(context).size.width/5,
      ),
      Container(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categorie.cat,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              Text(
              categorie.description,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15
                ),
              
              ),
              
              
        ],)
      )

    ]
    ),
    );
  }
}