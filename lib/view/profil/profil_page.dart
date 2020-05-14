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

  @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
  }

  getProfileContent() async {
    
    if ( widget.poster == null) {
      talent = await talentService.getCurrentUser();
      nom = talent.nom;
      prenom = talent.prenom;
      email = talent.email;
      nationalite = talent.nationalite;
      description = talent.description;
      photoUrl = talent.photoProfile;
    } else {
      nom = widget.poster.nom;
      prenom = widget.poster.prenom;
      email = widget.poster.email;
      nationalite = widget.poster.nationalite;
      description = widget.poster.description;
      photoUrl = widget.poster.photoProfile;
    }
    getProfilPosts();
  }

  getProfilPosts() async {
    try {
      if(talent == widget.poster || widget.poster == null){
      posts = await postService.getProfilPosts(talent.uid, postCount);
      postCount = posts.length;
      }
      else{
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
          height: MediaQuery.of(context).size.height/2.6,
          margin: EdgeInsets.only(bottom:20),
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

              Expanded(
                              child: CircleAvatar(
                backgroundImage: photoUrl != ''
                    ? CachedNetworkImageProvider(photoUrl)
                    : AssetImage('assets/images/user_icon.png'),
                radius: 40,
            ),
              ),
            SizedBox(
              width:10,
            ),
            Expanded(
              flex: 2,
                          child: Column(
                crossAxisAlignment: 
                CrossAxisAlignment.start,
                children: <Widget>[
                Text(nom + ' ' + prenom,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(email + ', ' + nationalite,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38)),
             
              ]),
            )
            
            ]),
            SizedBox(
              height:20
            ),
             Text('description: '+description,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            
            Text('Category',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)),
            SizedBox(
              height: 8,
            )
          ]),
        ),
       /* Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width-10,
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                        child: Row(
                      children: <Widget>[
                        Text(
                          'Posts :',
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          postCount.toString(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if(talent == widget.poster)VerticalDivider(
                          color: Colors.black54,
                          width: 2,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if(talent == widget.poster)
                        RaisedButton.icon(
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
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ))
                      ],
                    ))))
          ],
        ),*/
        buildProfilPost()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: talent == widget.poster ? header(context, "profil",'Artness') : AppBar(title:Text('Profile'),),
        body: isWaiting ? circularProgress() : profileView());
  }
}
