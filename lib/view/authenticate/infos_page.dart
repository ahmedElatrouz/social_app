import 'package:flutter/material.dart';
import 'package:social_app/repository/talentAuth.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
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

  @override
  void initState() {
    print(photoUrl);
    super.initState();
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
                              TextStyle(fontSize: 30, color: Colors.blueGrey),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Nom",
                          change: (val) {
                            nom = val;
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Prenom",
                          change: (val) {
                            prenom = val;
                          },
                        )),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                            child: CreateField(
                          fieldName: "Genre",
                          change: (val) {
                            genre = val;
                          },
                        )),
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
                          fieldName: "Age",
                          change: (val) {
                            age = val;
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
                        Text(photoUrl),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadPost(
                                            profilPic: false,
                                            firstPost: true,
                                            newPost : false,
                                            nom: nom,
                                          ))).then((val) {
                                photoUrl = val;
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text('add your first post',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: RaisedButton(
                            highlightColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            color: Colors.lightBlueAccent,
                            child: Text('Register',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white)),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                //setState(() => loading = true);
                                dynamic result = await _auth
                                    .signUp(widget.email, widget.password)
                                    .then((currentUser) =>
                                        _auth.createDocumment(
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
                                            description));

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
