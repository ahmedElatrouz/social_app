import 'package:flutter/material.dart';
import 'package:social_app/view/authenticate/infos_page.dart';
import 'package:social_app/view/authenticate/infos_pro_page.dart';
import 'package:social_app/view/shared/field.dart';
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
                          Text(
                            'Register',
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
                          CreateField(
                            change:(val){
                              setState(() {
                                email = val;
                              });
                            } ,
                          fieldName: "Email",
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CreateField(fieldName: "Password",
                          change: (val){
                            setState(() {
                              password = val;
                            });
                          },),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                
                              RaisedButton(
                                  highlightColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    child: Text('Talent',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfosPage(
                                                    email: email,
                                                    password: password,
                                                  )));
                                    }
                                  }),

                                  SizedBox(width: 10,),

                              RaisedButton(
                                  highlightColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    child: Text('professionnel',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => InfosProPage(
                                                    email: email,
                                                    password: password,
                                                  )));
                                    }
                                  }),
                            ],
                          )
                        ],
                      ))),
            ),
          );
  }
}



