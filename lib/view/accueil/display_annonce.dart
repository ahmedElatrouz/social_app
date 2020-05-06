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
    //nom = widget.prof.nom;
    //prenom = widget.prof.prenom;
    descripton = widget.annonce.description;
  }

  @override
  void initState() {
    super.initState();
    infos();
  }

  buildAnnonceContent() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage('assets/images/3.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(blurRadius: 7.0, color: Colors.black)
                  ])),
          SizedBox(
            width: 10,
          ),
          Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Nom Prenom',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(color: Colors.blueGrey, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(descripton),
                ),
              )
            ],
          ))
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          child: Column(
            children: <Widget>[
              buildAnnonceContent(),
              SizedBox(
                height: 10,
              ),
              buildAnnonceFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
