import 'package:flutter/material.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/services/categorieService.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/loading.dart';
import 'package:social_app/view/shared/reusable_text_field.dart';

class InfosPage extends StatefulWidget {
  final String email;
  final String password;

  InfosPage({@required this.email, @required this.password});

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  final TalentAuth _auth = TalentAuth();
  final _formKey = GlobalKey<FormState>();
  CategorieService categorieService = CategorieService();
  String error = '';
  String nom = '';
  String prenom = '';
  String genre = '';
  String nationalite = '';
  String tel = '';
  String age = '';
  String photoUrl = '';
  String videoUrl = '';
  String description = '';
  bool loading = false;
  String selected;
  List<String> catsName = [];
  String selectedCat;

  @override
  void initState() {
    print(photoUrl);
    allCategories();
    super.initState();
  }

  allCategories() async {
    List<Categorie> categories = await categorieService.allCategories();
    for (Categorie cat in categories) {
      setState(() {
        catsName.add(cat.cat);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Talent',
                          style:
                              TextStyle(fontSize: 40,
                               color: Colors.blueGrey,
                               fontFamily: 'JosefinSans',
                               fontWeight: FontWeight.bold,
                               ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: CreateField(
                                fieldName: "Nom",
                                change: (val) {
                                  nom = val;
                                },
                              )),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: CreateField(
                                fieldName: "Prenom",
                                change: (val) {
                                  prenom = val;
                                },
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: DropdownButtonFormField<String>(
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
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: CreateField(
                                fieldName: "Age",
                                change: (val) {
                                  age = val;
                                },
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Nationalite",
                          change: (val) {
                            nationalite = val;
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Tel",
                          change: (val) {
                            tel = val;
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Description",
                          change: (val) {
                            description = val;
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                              isDense: true,
                              validator: (val) =>
                                  val.isEmpty ? 'cant be empty' : null,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  hintText: 'Categorie',
                                  hintStyle: TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold)),
                              value: selectedCat,
                              items: catsName
                                  .map((label) => DropdownMenuItem(
                                        child: Text(label),
                                        value: label,
                                      ))
                                  .toList(),
                              onChanged: (value)  {
                                setState(()  {
                                  selectedCat = value;
                                  print(selectedCat);
                                });
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Url :",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(photoUrl),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadPost(
                                          post: witchPost.firstPost,
                                          nom: nom,
                                        ))).then((val) {
                              photoUrl = val;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text('add your first post',
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.black,
                                  fontFamily: 'JosefinSans',fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        RaisedButton(
                          highlightColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.lightBlueAccent,
                          child: Text('Register',
                              style: TextStyle(
                                  fontSize: 25.0, color: Colors.white,
                                  fontFamily: 'JosefinSans',fontWeight: FontWeight.bold)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              //setState(() => loading = true);
                              genre = selected;
                              Categorie cat = await categorieService
                                  .getCategory(selectedCat);
                              print('$cat 1');
                              dynamic result = await _auth
                                  .signUp(widget.email, widget.password)
                                  .then((currentUser) => _auth.createDocumment(
                                      age,
                                      widget.email,
                                      genre,
                                      nationalite,
                                      nom,
                                      widget.password,
                                      prenom,
                                      tel,
                                      photoUrl,
                                      videoUrl,
                                      description,
                                      cat));

                              if (result == null) {
                                setState(() {
                                  //loading = false;
                                  error = "this email is already used!";
                                  //Navigator.push(context,MaterialPageRoute(builder: (context)=>ActualitePage()));
                                });
                              } else {
                                setState(() {
                                  // loading = false;
                                  Navigator.pushReplacementNamed(
                                      context, Home.id);
                                });

                                //ActualitePage();

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
          );
  }
}
