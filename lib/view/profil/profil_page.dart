import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/post_widget.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  final Talent poster;
  ProfilPage({this.poster});
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
  String cat = ' ';

  @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
  }

  getProfileContent() async {
    if (widget.poster == null) {
      talent = await talentService.getCurrentUser();
      nom = talent.nom;
      prenom = talent.prenom;
      email = talent.email;
      nationalite = talent.nationalite;
      description = talent.description;
      photoUrl = talent.photoProfile;
      cat = talent.categorie.cat;
    } else {
      nom = widget.poster.nom;
      prenom = widget.poster.prenom;
      email = widget.poster.email;
      nationalite = widget.poster.nationalite;
      description = widget.poster.description;
      photoUrl = widget.poster.photoProfile;
      cat = widget.poster.categorie.cat;
    }
    getProfilPosts();
  }

  getProfilPosts() async {
    try {
      if (talent == widget.poster || widget.poster == null) {
        posts = await postService.getProfilPosts(talent.uid, postCount);
        postCount = posts.length;
      } else {
        posts = await postService.getProfilPosts(widget.poster.uid, postCount);
        postCount = posts.length;
      }
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
            poster: widget.poster == null ? talent : widget.poster,
          )
      ],
    );
  }

  Widget profileView() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.6,
          margin: widget.poster == null ? EdgeInsets.only(bottom: 0) : EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(5.0),
                  bottomRight: const Radius.circular(5.0))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: photoUrl != ''
                            ? CachedNetworkImageProvider(photoUrl)
                            : AssetImage('assets/images/user_icon.png'),
                        radius: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(prenom + ' ' + nom,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Text(email + ', ' + nationalite,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black38)),
                            ]),
                      )
                    ]),
                SizedBox(height: 20),
                Text('description: ' + description,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87)),
                Text(cat == null ? 'categorie' : cat,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45)),
                SizedBox(
                  height: 8,
                )
              ]),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.poster == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton.icon(
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UploadPost(
                                    post: witchPost.profilePic,
                                  )));
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text(
                      'profil picture',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              )
          ],
        ),
        buildProfilPost()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: widget.poster == null
            ? header(context, "profil", 'Artness')
            : AppBar(
                title: Text('Profile'),
              ),
        body: isWaiting ? circularProgress() : profileView());
  }
}
