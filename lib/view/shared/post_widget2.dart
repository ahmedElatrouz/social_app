import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';

class PostWidget extends StatelessWidget {
  final Post post;
  final Talent poster = Talent(
    nom: 'ahmed',
    prenom: 'elatrouz',
  );

  PostWidget({
    @required this.post,
    //@required this.poster,
    @required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[50], //Color(0xFFF0F0F0),
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: InkWell(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/3.jpg",
                  ),
                ),
                contentPadding: EdgeInsets.all(0),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      poster.nom + poster.prenom,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      post.description,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: post.photoUrl != null
                    ? Image.network(post.photoUrl)
                    : Image.asset(
                        'assets/images/ahmed.jpg',
                        height: 170,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
              ),
              
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
