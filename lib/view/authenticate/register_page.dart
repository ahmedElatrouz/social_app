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


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => widget.togleView(),
            icon:Icon(Icons.person),
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

          SizedBox(height: 8,),
          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'can\'t be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "nom",
              labelStyle: TextStyle(fontSize: 15)
            ),

            onChanged: (val) {
              setState(() => nom = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Prenom",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => prenom = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "genre",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => genre = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "nationalite",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => nationalite = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.length==10  ? 'numero de telephone n\'est pas valide' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Tel",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => tel = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Email",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {setState(() => email = val);},
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => password = val);
            },
          )),


          Expanded(child: TextFormField(
            validator: (val) => val.isEmpty ? 'cant be empty' : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Age",
              labelStyle: TextStyle(fontSize: 15)
            ),
            onChanged: (val) {
              setState(() => age = val);
            },
          )),


          Expanded(child: RaisedButton(
            
            highlightColor: Colors.purple,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30) ),
            color: Colors.blueAccent,
            child: Text('Register',style:TextStyle(fontSize: 15.0,color: Colors.white)),

            onPressed: () async{
              if(_formKey.currentState.validate()){
                setState(() => loading = true);
                dynamic result=_auth.signUp(email, password)
                .then((currentUser) =>_auth.createCollection(age, email, genre, nationalite, nom, password, prenom, tel));
                if(result == null){
                  loading = false;
                  error = 'you have problem in your email';
                }
              }
            },
          )),
          SizedBox(height: 8,),
          //Text(error,style: TextStyle(color: Colors.red),),
        ],
      ))),
    );
  }
}
