import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/services/categorieService.dart';
import 'package:social_app/view/admin/create_category_page.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<CategorieCard> catCards = [];
  CategorieService categorieService = CategorieService();
  bool isWaiting = false;

  @override
  void initState() {
    super.initState();
    loading();
    getCategories();
  }

  @override
  void dispose() {
    loading();
    super.dispose();
  }

  loading() {
    setState(() {
      isWaiting = !isWaiting;
    });
  }

  getCategories() async {
    List<Categorie> categories = await categorieService.allCategories();
    for (Categorie c in categories) {
      catCards.add(CategorieCard(categorie: c));
    }
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateCategoryPage()))),
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.purple[300],
            title: Text(
              'Categories',
              
            )),
        body: SingleChildScrollView(
                  child: Column(
            children:catCards
          )),
      ),
      inAsyncCall: isWaiting,
    );
  }
}

class CategorieCard extends StatelessWidget {
  final Categorie categorie;

  const CategorieCard({this.categorie});
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
            child: ListView(children: <Widget>[
              Text(
                'categorie: ' + categorie.cat,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'description: ' + categorie.description,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
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
      onTap: () => _showDialog(context),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Colors.grey,
            image: DecorationImage(
              image: CachedNetworkImageProvider(categorie.imageUrl),
              fit: BoxFit.cover,
            )),
        margin: EdgeInsets.fromLTRB(5, 4, 5, 0),
        height: 100,
        width: MediaQuery.of(context).size.width-10,
        child: Center(
          child: Container(
            child: Text(
              categorie.cat,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Signatra'),
            ),
          ),
        ),
      ),
    );
  }
}
