import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/post_widget.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {

  bool isWaiting = false;
  Talent talent =new Talent();
  TalentService talentService = TalentService();

  List<Post> posts = [];
  Post post = Post();
  PostService postService = PostService();
  int postCount = 0;

  @override
  initState() {
    super.initState();
    isWaiting = true;
    getTalent();
    print(talent);
    getProfilPosts();
  }

  getTalent() async {
    try {
      talent = await talentService.getCurrentUser();
      print(talent);
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  getProfilPosts() async {
    try {
      posts = await postService.getProfilPosts(talent.uid, postCount);
      print(posts);
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
    return Column(
      children: <Widget>[
        for (int i=0; i < posts.length; i++)
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
            SizedBox(
              height: 3,
            ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/3.jpg'),
              radius: 60,
            ),
            SizedBox(
              height: 8,
            ),
           Text(talent.nom + ' ' + talent.prenom,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
            Text(talent.email + ', ' + talent.nationalite,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38)),
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
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RaisedButton(
                highlightColor: Colors.blue,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadPost(
                                currentTalent: talent,
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'new post',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
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
        appBar: header(context, "profil"),
        body: isWaiting ? circularProgress() : profileView());
  }
}
