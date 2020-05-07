import 'package:flutter/material.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';

class DisplayAnnonce extends StatefulWidget {
  final Annonce annonce;
  final Professionnel prof;
  DisplayAnnonce({this.annonce, this.prof});
  @override
  _DisplayAnnonceState createState() => _DisplayAnnonceState();
}

class _DisplayAnnonceState extends State<DisplayAnnonce> {
  String nom = '';
  String prenom = '';
  String descripton = '';

  infos() {
    nom = widget.prof.nom;
    prenom = widget.prof.prenom;
    descripton = widget.annonce.description;
  }

  @override
  void initState() {
    super.initState();
    infos();
  }

  buildAnnonceContent() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: AssetImage('assets/images/3.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ])),
              SizedBox(width: 10,),
              Text(
                nom +' '+ prenom,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]
          ),
          Container(
           
            margin: EdgeInsets.symmetric( vertical: 5),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              descripton,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
    )
    );
  }

  handleComment() {
    print('comments');
  }

  buildAnnonceFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => handleComment(),
              child: Icon(
                Icons.comment,
                //color: Colors.blue,
                size: 30,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                '0 comment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildAnnonceContent(),
          buildAnnonceFooter(),
        ],
      ),
    );
  }
}
