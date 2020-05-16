
import 'package:flutter/material.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/view/admin/create_category_page.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
 static List<Categorie> categories=[
  Categorie(cat:'Music',description:'cette categorie rejoint les talents en musique'),
  Categorie(cat:'Dance',description:'cette categorie rejoint les talents en musique'),
  Categorie(cat:'Photography',description:'cette categorie rejoint les talents en musique')];
  List<CategorieCard> catCards;
 @override
  void initState() {
    super.initState();
     catCards=[CategorieCard(categorie:categories[0]),CategorieCard(categorie:categories[1]),CategorieCard(categorie:categories[2])];
 
  }
  @override
  void dispose() {
    super.dispose();
  }

  
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateCategoryPage()))),
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor:Colors.purple[300],
        title:Text('Categories')
      ),
      body:ListView(
        children: catCards
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
                        image: DecorationImage(image: AssetImage('assets/images/'+categorie.cat+'.jpg'),fit: BoxFit.cover,)
      ),
      
      margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
      height: 100,
      width: MediaQuery.of(context).size.width/2,
      child: Center(
        child: Container(
          child: Text(
            categorie.cat,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900
              ),
            
            ),
        ),
      ),
      ),
    );
  }
}