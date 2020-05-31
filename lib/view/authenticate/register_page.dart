import 'package:flutter/material.dart';
import 'package:social_app/view/authenticate/infos_page.dart';
import 'package:social_app/view/authenticate/infos_pro_page.dart';
import 'package:social_app/view/shared/loading.dart';
import 'package:social_app/view/shared/reusable_text_field.dart';

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
            body: Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 30),
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                        child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30,),
                          Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'JosefinSans',
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
                            height: 50,
                          ),
                          Container(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
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
                                                fontSize: 25.0,
                                                color: Colors.white,
                                                fontFamily: 'JosefinSans',
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
                                                fontSize: 25,
                                                color: Colors.white,
                                                fontFamily: 'JosefinSans',
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
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          );
  }
}



