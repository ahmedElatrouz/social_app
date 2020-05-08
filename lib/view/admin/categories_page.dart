import 'package:flutter/material.dart';
import 'package:social_app/model/Categorie.dart';
List<Categorie> categories=[
  Categorie(cat:'Music',description:'cette categorie rejoint les talents en musique'),
  Categorie(cat:'Music',description:'cette categorie rejoint les talents en musique'),
  Categorie(cat:'Music',description:'cette categorie rejoint les talents en musique')];
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategorieCard> catCards=[CategorieCard(categorie:categories[0]),CategorieCard(categorie:categories[1]),CategorieCard(categorie:categories[0])];
 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor:Colors.purple[300],
        title:Text('Categories')
      ),
      body:ListView(
        children: <Widget>[
          CategorieCard(categorie: categories[0],),
          CategorieCard(categorie: categories[0],),
          CategorieCard(categorie: categories[0],)
        ],
      ),
    );
  }
}

class CategorieCard extends StatelessWidget {
  final Categorie categorie;

  const CategorieCard({ this.categorie}) ;
void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(categorie.cat),
          content: Container(
            padding: EdgeInsets.all(7),
            color: Colors.grey[100],
            height: 200,
            child: ListView(
              children:<Widget>[
                Text(
              'categorie: '+categorie.cat,
              style: TextStyle(
                color: Colors.black,
                 fontSize: 20,
                fontWeight: FontWeight.w600
                ),
              
              ),
              SizedBox(
                height:10
              ),
              
              Text(
              'description: '+categorie.description,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600
                ),
              
              ),
              ]
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>_showDialog(context),
          child: Container(
        padding:EdgeInsets.all(10),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
                        Radius.circular(5.0)),
                        color: Colors.white,
                        image: DecorationImage(image: AssetImage('assets/images/back.jpg'),fit: BoxFit.cover,)
      ),
      
      margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
      height: 100,
      width: MediaQuery.of(context).size.width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'categorie: '+categorie.cat,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w900
              ),
            
            ),
            Text(
            'description: '+categorie.description,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w900
              ),
            
            ),
            
            
            
      ],),
      ),
    );
  }
}