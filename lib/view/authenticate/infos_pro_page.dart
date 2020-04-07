import 'package:flutter/material.dart';
import 'package:social_app/service/profAuth.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/shared/loading.dart';

class InfosProPage extends StatefulWidget {
  final String email;
  final String password;
  InfosProPage({@required this.email, @required this.password});

  @override
  _InfosProPageState createState() => _InfosProPageState();
}

class _InfosProPageState extends State<InfosProPage> {
  final ProfAuthService _profAuth = ProfAuthService();
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
              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Profetionnel',
                          style: TextStyle(fontSize: 30,color: Colors.blueGrey),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Expanded(child: createField("Nom")),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(child: createField("Prenom")),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(child: createField("Genre")),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(child: createField("Nationalite")),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(child: createField("Tel")),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(child: createField("Age")),
                          SizedBox(
                            height: 15,
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
                                        fontSize: 20.0, color: Colors.white)),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  //setState(() => loading = true);
                                  dynamic result = await _profAuth
                                      .signUp(widget.email, widget.password)
                                      .then((currentUser) =>
                                          _profAuth.createCollection(
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
                                      // loading = false;
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()));
                                    });

                                    //ActualitePage();

                                  }
                                }

                                //ActualitePage();
                              }),
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
