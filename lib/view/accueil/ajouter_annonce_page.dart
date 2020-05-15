import 'package:flutter/material.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/services/annonceService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AjouterAnnoncePage extends StatefulWidget {
  final Professionnel pro;

  const AjouterAnnoncePage({Key key, this.pro}) : super(key: key);
  @override
  _AjouterAnnoncePageState createState() => _AjouterAnnoncePageState();
}

class _AjouterAnnoncePageState extends State<AjouterAnnoncePage> {
  String titre = '';
  String contenu = '';
  AnnonceService annonceService = AnnonceService();
  TextEditingController controller = TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isWaiting = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(15),
                    child: TextFormField(
                      validator: (String value) {
                        if (value.length == 0) {
                          return "Entrez un titre";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        titre = value;
                        //this.controller.clear();
                      },
                      cursorColor: Colors.purple,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.purple)),
                          focusColor: Colors.black,
                          fillColor: Colors.black,
                          hoverColor: Colors.black,
                          hintText: 'titre',
                          hintStyle: TextStyle(color: Colors.black38),
                          icon: Icon(
                            Icons.title,
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          border: UnderlineInputBorder()),
                    ),
                  ),
                  Container(
                      child: TextFormField(
                    controller: controller,
                    cursorColor: Colors.purple,
                    validator: (String value) {
                      if (value.length < 30) {
                        return "Entrez plus que 30 caracteres ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple)),
                        hintText: 'Entrez votre annonce ici',
                        border: OutlineInputBorder()),
                    maxLines: 10,
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 120,
                    child: RaisedButton(
                      child: Text('Publier'),
                      color: Colors.purple,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            setState(() {
                              isWaiting = true;
                            });
                            await addAnnonce();
                            setState(() {
                              this.controller.clear();
                              isWaiting = false;
                            });
                          }
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: isWaiting,
      ),
    );
  }

  addAnnonce() async {
    Professionnel pro = await ProfessionelService().getCurrentPro();
    Annonce annonce = Annonce(
        proRef: pro.proID, description: controller.text, date: DateTime.now());
    int a = 0;
    a = await annonceService.createAnnonce(annonce);
    setState(() {
      isWaiting = false;
    });
    if (a == 0) print('erreur:annonce non publiée!!');
  }
}
