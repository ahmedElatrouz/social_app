import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/service/auth.dart';
import 'package:social_app/view/accueil/actualite_page.dart';
import 'package:social_app/view/accueil/home.dart';
import 'package:social_app/view/shared/loading.dart';

class LoginPage extends StatefulWidget {

  static const String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';
  bool loading = false;

  //bool isAuth = false;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key:_formKey ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[


                TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  onChanged: (val) {setState(() => email = val);},
                  validator: (val) => val.isEmpty ? 'your email not correct' : null,
                  
                  decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(
                        Icons.mail,
                        color: Colors.grey,
                      ),
                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    
                ),
                SizedBox(height: 20,),


                TextFormField(
                  onChanged: (val) { setState(() => password = val); },
                  validator: (val) => val.length<6 ? 'your password not correct' : null,
                  decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
                    ),
                 ),
                SizedBox(height: 20,),




                RaisedButton(
                    highlightColor: Colors.purple,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.blue,
                    child: Text('Login',style: TextStyle(fontSize: 20.0, color: Colors.white)),

                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        /*setState(() => loading = true );
                        dynamic result= await _auth.signIn(email, password);
                        
                        if(result == null){
                          setState(() {
                            loading = false;
                            error = 'you have a problem in your email';
                             //Navigator.pushNamed(context, ActualitePage.id);
                          });
                        }
                        else{*/
                         Navigator.pushReplacementNamed(context,"Home" /*ActualitePage.id*/);
                          
                          //Home();
                          //loading=false;
                       // }
                      }
                    }),
                SizedBox(height: 20,),
                Text(error,style: TextStyle(color:Colors.red,)),
              ]),
        ),
      ),
    );
  }
}
