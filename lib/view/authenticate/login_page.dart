import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/main.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/repository/authService.dart';
import 'package:social_app/repository/talentRepositoryImpl.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/loading.dart';
import 'package:social_app/view/shared/reusable_text_field.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TalentService talentService = TalentService();

  //final TalentAuth _auth = TalentAuth();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back.jpg'),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only(top: 90),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.only(top: 100),
                    padding: EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          CreateLogInField(
                              type: "Email",
                              onChange: (val) {
                                setState(() => email = val);
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          CreateLogInField(
                              type: "Password",
                              onChange: (val) {
                                setState(() => password = val);
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                              highlightColor: Colors.blue[900],
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              color: Colors.purple[200],
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 8),
                                child: Text('Login',
                                    style: TextStyle(
                                        fontSize: 25.0, color: Colors.white)),
                              ),
                              onPressed: () {
                                logIn();
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text(error,
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      inAsyncCall: loading,
    );
  }

  logIn() async {
    if (_formKey.currentState.validate()) {
     /* setState(() {
        loading = true;
      });*/
      try {
        dynamic result = await AuthService().signIn(
            //"youssef@email.com", "youssegf");
            //"netero@hunter.com", "123456");
            "admin@email.com","123456");
            setState(() => loading = false);
        if (result == 0) {
          setState(() {
            error = 'you have a problem in your email';
          });
        } else {
          Navigator.pushReplacementNamed(context, Home.id);
        }
      } catch (e) {setState(() => loading = false);print(e);}
    }
    
  }

  @override
  void dispose() {
    super.dispose();
  }
}
