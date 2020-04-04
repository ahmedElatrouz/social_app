import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/accueil/actualite_page.dart';
import 'package:social_app/view/shared/loading.dart';

class InfosPage extends StatefulWidget {
  final String email;
  final String password;

  InfosPage({this.email, this.password});

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String nom = '';
  String prenom = '';
  String genre = '';
  String nationalite = '';
  String tel = '';
  String age = '';
  bool loading = false;

  void assignAttribut(String att, var val) {
    switch (att) {
      case 'Nom':
        nom = val;
        break;
      case 'Prenom':
        prenom = val;
        break;
      case 'Genre':
        genre = val;
        break;
      case 'Nationalite':
        nationalite = val;
        break;
      case 'Tel':
        tel = val;
        break;
      case 'Age':
        age = val;
        break;
      default:
        return null;
        break;
    }
  }

//methode permet de creer les champs
  Widget createField(String fieldName) {
    return TextFormField(
      //si on est dans l'email field on change le clavier vers le type email
      keyboardType: fieldName == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      //si on est dans le field password l'ecriture devient obscure (pour que personne ne voit
      obscureText: fieldName == "Password" ? true : false,
      validator: (val) => val.isEmpty ? 'cant be empty' : null,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        labelText: fieldName,
        labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onChanged: (val) {
        setState(() => assignAttribut(fieldName, val));
        print(prenom);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          createField("Nom"),
                          SizedBox(
                            height: 20,
                          ),
                          createField("Prenom"),
                          SizedBox(
                            height: 20,
                          ),
                          createField("Genre"),
                          SizedBox(
                            height: 20,
                          ),
                          createField("Nationalite"),
                          SizedBox(
                            height: 20,
                          ),
                          createField("Tel"),
                          SizedBox(
                            height: 20,
                          ),
                          createField("Age"),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            highlightColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.blueAccent,
                            child: Text('Register',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _auth
                                    .signUp(widget.email, widget.password)
                                    .then((currentUser) =>
                                        _auth.createCollection(
                                            age,
                                            widget.email,
                                            genre,
                                            nationalite,
                                            nom,
                                            widget.password,
                                            prenom,
                                            tel));
                                if (result == null) {
                                  loading = false;
                                  error = "this email adresse doesn't exist!";
                                } else {
                                  Navigator.pushNamed(
                                      context, ActualitePage.id);
                                      loading=false;
                                }
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(error,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ],
                      ))),
            ),
          );
  }
}
