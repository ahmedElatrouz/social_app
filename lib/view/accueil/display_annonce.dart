import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Annonce.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/view/accueil/comments.dart';

class DisplayAnnonce extends StatefulWidget {
  final Annonce annonce;
  final Professionnel prof;
  DisplayAnnonce({this.annonce, this.prof});
  @override
  _DisplayAnnonceState createState() => _DisplayAnnonceState();
}

class _DisplayAnnonceState extends State<DisplayAnnonce> {
  bool comment;
  String nom = '';
  String prenom = '';
  String descripton = '';
  String year = '';
  String day = '';
  String month = '';
  String hour = '';
  String min = '';
  String photoProfile = '';
  String proId = '';
  String annonceId = '';

  infos() {
    nom = widget.prof.nom;
    prenom = widget.prof.prenom;
    descripton = widget.annonce.description;
    year = widget.annonce.date.year.toString();
    month = widget.annonce.date.month.toString();
    day = widget.annonce.date.day.toString();
    hour = widget.annonce.date.hour.toString();
    min = widget.annonce.date.minute.toString();
    photoProfile = widget.prof.photoProfile;
    annonceId = widget.annonce.id;
    proId = widget.prof.proID;
    print(annonceId);
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
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: photoProfile != ''
                          ? CachedNetworkImageProvider(photoProfile)
                          : AssetImage('assets/images/3.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 7.0, color: Colors.black)
                  ])),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nom + ' ' + prenom,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(day + '/' + month + '/' + year + '  ' + hour + ':' + min)
            ],
          ),
        ]),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
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
    ));
  }

  buildAnnonceFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () =>
                  showComents(context, annonceID: annonceId, proID: proId),
              child: Icon(
                Icons.chat,
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

showComents(BuildContext context, {String annonceID, String proID}) {
  print(annonceID);
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Comments(
                annonceID: annonceID,
                proID: proID,
              )));
}








