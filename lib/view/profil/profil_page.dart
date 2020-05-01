import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/post_widget.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  Talent talent = Talent();
  bool isWaiting = false;
  TalentService talentService = TalentService();
  List<Post> posts = [];
  PostService postService = PostService();
  int postCount = 0;
  String nom = '';
  String prenom = '';
  String email = '';
  String nationalite = '';
  String description = '';
  String photoUrl = ' ';

  @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
  }

  getProfileContent() async {
    talent = await talentService.getCurrentUser();
    nom = talent.nom;
    prenom = talent.prenom;
    email = talent.email;
    nationalite = talent.nationalite;
    description = talent.description;
    photoUrl = talent.photo;
    getProfilPosts();
    print(photoUrl);
  }

  getProfilPosts() async {
    try {
      posts = await postService.getProfilPosts(talent.uid, postCount);
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  buildProfilPost() {
    if (isWaiting) {
      return circularProgress();
    }
    var lenght = 0;
    if (posts != null) lenght = posts.length;
    return Column(
      children: <Widget>[
        for (int i = 0; i < lenght; i++)
          PostWidget(
            post: posts[i],
            talent: talent,
          )
      ],
    );
  }

  Widget profileView() {
    return ListView(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Color(0xFF009688),
              borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(60.0),
                  bottomRight: const Radius.circular(60.0))),
          child: Column(children: <Widget>[
            CircleAvatar(
              backgroundImage: photoUrl != ''
                  ? CachedNetworkImageProvider(photoUrl)
                  : AssetImage('assets/images/ahmed.jpg'),
              radius: 60,
            ),
            SizedBox(
              height: 8,
            ),
            Text(nom + ' ' + prenom,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text(email + ', ' + nationalite,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38)),
            Text(description,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87)),
            Text('Category',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)),
            SizedBox(
              height: 8,
            )
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 60,
                width: 350,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:
                    Padding(padding: const EdgeInsets.all(20),
                     child: InkWell(
                       child: Row(
                         children: <Widget>[
                         ],
                       )
                     ))

                )
          ],
        ),
        Divider(
          height: 0.0,
        ),
        buildProfilPost()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF009688).withOpacity(0.5),
        appBar: header(context, "profil"),
        body: isWaiting ? circularProgress() : profileView());
  }
}
