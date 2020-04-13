import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/repository/talentAuth.dart';
//import 'package:social_app/view/accueil/actualite_page.dart';
//import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/shared/loading.dart';
import 'package:social_app/view/shared/reusable_text_field.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   final TalentAuthService _auth = TalentAuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Log In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),

                      CreateLogInField(
                        type: "Email", 
                        onChange: (val){ setState(() => email = val);}
                        ),

                      SizedBox(
                        height: 20,
                      ),
                      

                      CreateLogInField(
                        type: "Password",
                        onChange: (val){
                          setState(() => password = val);}
                        ),

                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                          highlightColor: Colors.blue,
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Colors.lightBlueAccent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 8),
                            child: Text('Login',
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.white)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true );
                        dynamic result= await _auth.signIn(
                          "dafali@email.com", "123456789");
                        
                        if(result == null){
                          setState(() {
                            loading = false;
                            error = 'you have a problem in your email';
                          });
                        }
                        else{
                              Navigator.pushReplacementNamed(context, Home.id );
                              loading=false;
                            }
                            }
                          }),

                      SizedBox(
                        height: 20,
                      ),

                      Text( error , style: TextStyle(color: Colors.red,)),
                    ]),
              ),
            ),
          );
  }
}
