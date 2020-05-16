import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/services/categorieService.dart';

class CreateCategoryPage extends StatefulWidget {
  @override
  _CreateCategoryPageState createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  CategorieService categorieService=CategorieService();

  String nom;
  String description;
  bool isWaiting;
  TextEditingController controller = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  
  addCategorie()async{
      Categorie categorie=Categorie(cat:nom,description: description);
   await  categorieService.createCategorie(categorie);
   setState(() {
      isWaiting = false;
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isWaiting=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title:Text('Ajouter categorie'),),
         body: ModalProgressHUD(
                    child: SingleChildScrollView(
             child: Container(
                 height: MediaQuery.of(context).size.height,
                     color: Colors.white,
        child: Form(
                    key: _formKey,
                      child: Column(
                   children: <Widget>[
                     Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
                 validator: (String value) {
                   if (value.length == 0) {
                     return "Entrez un nom";
                   }
                   return null;
                 },
                 onSaved: (String value) {
                   nom = value;
                 },
                 cursorColor: Colors.purple,
                 decoration: InputDecoration(
                     focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple)),
                     focusColor: Colors.black,
                     fillColor: Colors.black,
                     hoverColor: Colors.black,
                     hintText: 'Nom du categorie',
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
                     
            margin: EdgeInsets.all(15),
                 child: TextFormField(
            controller: controller,
            cursorColor: Colors.purple,
            validator: (String value) {
                 if (value.length < 10) {
                   return "Entrez plus que 10 caracteres ";
                 }
                 return null;
            },onSaved: (String value) {
                   description = value;
                 },
            decoration: InputDecoration(
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.purple)),
                   hintText: 'Entrez la description ici',
                   border: OutlineInputBorder()),
            maxLines: 10,
                       )),
                       SizedBox(
            height: 20,
                       ),
                       Container(
            height: 50,
            width: 120,
            child: RaisedButton(
                 child: Text('Ajouter',style: TextStyle(color:Colors.white),),
                 color: Colors.purple[200],
                 onPressed: () async {
                   if (_formKey.currentState.validate()) {
                     if (_formKey.currentState.validate()) {
                       _formKey.currentState.save();
                       setState(() {
            isWaiting = true;
                       });
                       await addCategorie();
                       setState(() {
            this.controller.clear();
            isWaiting = false;
                       });
                     }
                   }
                 },
            ),
                       )
                  ],)),
      ),
             ), inAsyncCall: isWaiting,
         ),
    );
  }
}