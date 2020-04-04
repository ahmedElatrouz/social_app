import 'package:flutter/material.dart';
//import 'package:social_app/service/auth.dart';
import 'package:social_app/view/authenticate/infos_page.dart';
import 'package:social_app/view/shared/loading.dart';

class Register extends StatefulWidget {

  static const String id = 'register_page';


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  String error;

  String email = '';
  String password = '';
  String age = '';
  bool loading = false;

  void assignAttribut(String att, var val) {
    switch (att) {
      case 'Email':email = val;
        break;
      case 'Password':password = val;
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
      keyboardType: fieldName == "Email"? TextInputType.emailAddress :TextInputType.text,

      //si on est dans le field password l'ecriture devient obscure (pour que personne ne voit le password)
      obscureText: fieldName == "Password",
      validator: (val) => val.isEmpty ? 'cant be empty' : null,
      decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      labelText: fieldName,
      labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      onChanged: (val) {
    setState(() => assignAttribut(fieldName, val));
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
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          createField("Email"),

                          SizedBox( height: 20,),
                         
                          createField("Password"),

                          SizedBox( height: 20,),

                          RaisedButton(
                            highlightColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                            color: Colors.blueAccent,
                            child: Text('more Infos',
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.white,
                                fontWeight: FontWeight.bold)),
                            onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  
                                  Navigator.push(context, 
                                  MaterialPageRoute(
                                    builder: (context)=>InfosPage(email: email,password: password,))
                                    );
                            }
                            }
                          )
                         
                        ],
                      ))),
            ),
          );
  }
}
