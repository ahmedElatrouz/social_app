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
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                      image: photoProfile != ''
                          ? CachedNetworkImageProvider(photoProfile)
                          : AssetImage('assets/images/3.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)])),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                nom + ' ' + prenom,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                day + '/' + month + '/' + year + '  ' + hour + ':' + min,
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ]),
        Container(
          height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              //border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Text(
            descripton,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        )
      ],
    ));
  }

  showComents({String annonceID, String proID}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Comments(
                  annonceID: annonceID,
                  proID: proID,
                )));
  }

  buildAnnonceFooter() {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () => showComents(annonceID: annonceId, proID: proId),
          child: Icon(
            Icons.chat,
            //color: Colors.blue,
            size: 20,
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          child: Text(
            'comments',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        // border: Border.all(color: Colors.grey[400], width: 1),
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
