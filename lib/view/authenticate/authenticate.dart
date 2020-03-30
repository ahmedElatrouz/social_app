import 'package:flutter/material.dart';
import 'package:social_app/view/authenticate/login_page.dart';
import 'package:social_app/view/authenticate/register_page.dart';



class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

bool showLogIn = true;

void togleView(){
  setState(() {
    showLogIn = !showLogIn;
  });
}

  @override
  Widget build(BuildContext context) {
    if(showLogIn){
      return LoginPage(togleView: togleView,);
    }
    else {
      return Register(togleView: togleView,);
    }
  }
}