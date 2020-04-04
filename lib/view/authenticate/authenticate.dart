import 'package:flutter/material.dart';
import 'package:social_app/view/authenticate/login_page.dart';
import 'package:social_app/view/authenticate/register_page.dart';

class Authenticate extends StatefulWidget {
  static const String id = 'authenticate';
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(''),fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WELCOME TO SOCIAL APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                )
              ),

              SizedBox(
                height: 100,
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.lightBlueAccent,
                  child: MaterialButton(
                      height: 45,
                      child: Text('Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, LoginPage.id);
                      }
                      ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue,
                  child: MaterialButton(
                      height: 45,
                      child: Text('Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                          )),
                      onPressed: () {
                        Navigator.pushNamed(context, Register.id);
                      }
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
