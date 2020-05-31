import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:social_app/model/Categorie.dart';
import 'package:social_app/services/categorieService.dart';
import 'package:social_app/view/admin/categories_page.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';

class CreateCategoryPage extends StatefulWidget {
  @override
  _CreateCategoryPageState createState() => _CreateCategoryPageState();
}


class _CreateCategoryPageState extends State<CreateCategoryPage> {
  CategorieService categorieService = CategorieService();
  bool isUploading = false;
  String nom;
  String description;
  bool isWaiting;
  String imageUrl = '';
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  File image;


  addCategorie(context) async {
    Categorie categorie =
        Categorie(cat: nom, description: description, imageUrl: imageUrl);
    await categorieService.createCategorie(categorie);
    setState(() {
      isWaiting = false;
    });
    Navigator.pop(context);
  }


  @override
  void initState() {
    super.initState();
    isWaiting = false;
    print('$imageUrl here');
  }

  addImage() async {
    //Navigator.pop(context);
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      this.image = image;
    });
    print(image);
  }

  handleSunmitImage() async {
    setState(() {
      isUploading = true;
    });
    if (image != null) {
      imageUrl = await categorieService.handleSubmitImage(image, nom);
    }
    setState(() {
      image = null;
      isUploading = false;
    });
  }

  Widget buildUploadForm(context) {
    return ModalProgressHUD(
          child: Scaffold(
        body: ListView(
          children: <Widget>[
            if (image != null)
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 16,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: FileImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: RaisedButton(
                onPressed: () async{
                  setState(() {
                    isWaiting=true;
                  });
                  
                await  handleSunmitImage();
                setState(() {
                    isWaiting=false;
                  });

                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text('termier',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            )
          ],
        ),
      ), inAsyncCall: isWaiting,
    );
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? buildUploadForm(context)
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('Ajouter categorie',
              style: kAdminHeaderTextStyle,),
            ),
            body: ModalProgressHUD(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.length == 0) {
                                  return "Entrez un nom";
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                nom = value;
                              },
                              cursorColor: Colors.purple,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.purple)),
                                  focusColor: Colors.black,
                                  fillColor: Colors.black,
                                  hoverColor: Colors.black,
                                  hintText: 'Nom du categorie',
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
                              margin: EdgeInsets.all(15),
                              child: TextFormField(
                                controller: controller,
                                cursorColor: Colors.purple,
                                validator: (String value) {
                                  if (value.length < 10) {
                                    return "Entrez plus que 10 caracteres ";
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                  description = value;
                                },
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.purple)),
                                    hintText: 'Entrez la description ici',
                                    border: OutlineInputBorder()),
                                maxLines: 10,
                              )),
                          Container(
                            margin: EdgeInsets.all(15),
                            height: 40,
                            width: 500,
                            child: RaisedButton(
                              child: Text(
                                'Ajouter l\'image de categorie',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.blue[200],
                              onPressed: () => addImage(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              margin: EdgeInsets.all(15),
                              width: 500,
                              child: Text(imageUrl)),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 50,
                            width: 120,
                            child: RaisedButton(
                              child: Text(
                                'Ajouter',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.purple[200],
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    setState(() {
                                      isWaiting = true;
                                    });
                                    await addCategorie(context);
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
                      )),
                ),
              ),
              inAsyncCall: isWaiting,
            ),
          );
  }
}
