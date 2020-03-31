import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/shared/loading.dart';

class Register extends StatefulWidget {
  final Function togleView;
  Register({@required this.togleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String error;
  String nom = '';
  String prenom = '';
  String genre = '';
  String nationalite = '';
  String tel = '';
  String email = '';
  String login = '';
  String password = '';
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
      case 'Email':
        email = val;
        break;
      case 'Password':
        password = val;
        break;
      case 'Age':
        age = val;
        break;
      default:
        return null;
        break;
    }
  }

  Widget createField(String fieldName) {
    return Expanded(
        child: TextFormField(
          //si on est dans l'email field on change le clavier vers le type email
      keyboardType: fieldName == "Email"? TextInputType.emailAddress :TextInputType.text,
      //si on est dans le field password l'ecriture devient obscure (pour que personne ne voit le password)
      obscureText: fieldName == "Password",
      validator: (val) => val.isEmpty ? 'cant be empty' : null,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: fieldName,
          labelStyle: TextStyle(fontSize: 15)),
      onChanged: (val) {
        setState(() => assignAttribut(fieldName, val));
        print(prenom);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => widget.togleView(),
                  icon: Icon(Icons.person),
                  label: Text('SignIn'),
                )
              ],
              backgroundColor: Colors.brown[500],
              title: Text('SignUp'),
            ),
            body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8,
                        ),

                        createField("Nom"),
                        createField("Prenom"),
                        createField("Genre"),
                        createField("Nationalite"),
                        createField("Tel"),
                        createField("Email"),
                        createField("Password"),
                        createField("Age"),

                        Expanded(
                            child: RaisedButton(
                          highlightColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blueAccent,
                          child: Text('Register',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white)),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = _auth
                                  .signUp(email, password)
                                  .then((currentUser) => _auth.createCollection(
                                      age,
                                      email,
                                      genre,
                                      nationalite,
                                      nom,
                                      password,
                                      prenom,
                                      tel));
                              if (result == null) {
                                loading = false;
                                error = "this email adresse doesn't exist!";
                              }
                            }
                          },
                        )),
                        SizedBox(
                          height: 8,
                        ),
                        //Text(error,style: TextStyle(color: Colors.red),),
                      ],
                    ))),
          );
  }
}
