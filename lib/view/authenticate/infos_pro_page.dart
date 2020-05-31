import 'package:flutter/material.dart';
import 'package:social_app/repository/profAuth.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/profil/pro_profile_page.dart';
import 'package:social_app/view/shared/loading.dart';
import 'package:social_app/view/shared/reusable_text_field.dart';

class InfosProPage extends StatefulWidget {
  final String email;
  final String password;
  InfosProPage({@required this.email, @required this.password});

  @override
  _InfosProPageState createState() => _InfosProPageState();
}

class _InfosProPageState extends State<InfosProPage> {
  final ProfAuth _profAuth = ProfAuth();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  String nom = '';
  String prenom = '';
  String genre = '';
  String nationalite = '';
  String tel = '';
  String age = '';
  bool loading = false;
  String selected;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Container(
                  child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Profetionnel',
                                style: TextStyle(
                                    fontSize: 40,
                                    color: Colors.blueGrey,
                                    fontFamily: 'JosefinSans',
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  child: CreateField(
                                fieldName: "Nom",
                                change: (val) {
                                  nom = val;
                                },
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: CreateField(
                                fieldName: "Prenom",
                                change: (val) {
                                  prenom = val;
                                },
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              DropdownButtonFormField<String>(
                                  isDense: true,
                                  validator: (val) =>
                                      val.isEmpty ? 'cant be empty' : null,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    hintText: 'Genre',
                                    hintStyle: TextStyle(
                                        fontSize: 17,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.bold),
                                  ),
                                  value: selected,
                                  items: ["homme", "femme"]
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label),
                                            value: label,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() => selected = value);
                                  }),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: CreateField(
                                fieldName: "Nationalite",
                                change: (val) {
                                  nationalite = val;
                                },
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: CreateField(
                                fieldName: "Tel",
                                change: (val) {
                                  tel = val;
                                },
                              )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  child: CreateField(
                                fieldName: "Age",
                                change: (val) {
                                  age = val;
                                },
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              RaisedButton(
                                  highlightColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Text('Register',
                                        style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white,
                                            fontFamily: 'JosefinSans',
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      //setState(() => loading = true);
                                      genre = selected;
                                      dynamic result = await _profAuth
                                          .signUp(widget.email, widget.password)
                                          .then((currentUser) =>
                                              _profAuth.createDocument(
                                                  age,
                                                  widget.email,
                                                  genre,
                                                  nationalite,
                                                  nom,
                                                  widget.password,
                                                  prenom,
                                                  tel));

                                      if (result == null) {
                                        setState(() {
                                          //loading = false;
                                          error = "this email is already used!";
                                          //Navigator.push(context,MaterialPageRoute(builder: (context)=>ActualitePage()));
                                        });
                                      } else {
                                        setState(() {
                                          Navigator.pushReplacementNamed(
                                              context, ProProfilPage.id);
                                        });
                                      }
                                    }
                                  }),
                              SizedBox(
                                height: 20,
                              ),
                              Text(error,
                                  style: TextStyle(
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      ))),
            ),
          );
  }
}
