import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Professionnel.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/professionelService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/post_widget.dart';
import 'package:social_app/view/profil/upload_post_page.dart';
import 'package:social_app/view/shared/constants.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:social_app/view/shared/reusable_header.dart';

class ProfilPage extends StatefulWidget {
  final Talent poster;
  UserType visitor;
  ProfilPage({@required this.poster, this.visitor});
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
  String photoUrl = '';
  String cat = '';
  String uid = '';
  Professionnel pro = Professionnel();
  ProfessionelService proService = ProfessionelService();
  bool isLiked;
  String proID = '';
  @override
  initState() {
    super.initState();
    isWaiting = true;
    getProfileContent();
    getCurrentPro();
  }

  getCurrentPro() async {
    pro = await proService.getCurrentPro();
    if(pro != null) proID = pro.proID;
  }

  getProfileContent() async {
    
    if (widget.poster == null ) {
      talent = await talentService.getCurrentUser();
      nom = talent.nom;
      prenom = talent.prenom;
      email = talent.email;
      nationalite = talent.nationalite;
      description = talent.description;
      photoUrl = talent.photoProfile;
      uid = talent.uid;
      //cat = talent.categorie.cat;
    } else {
      nom = widget.poster.nom;
      prenom = widget.poster.prenom;
      email = widget.poster.email;
      nationalite = widget.poster.nationalite;
      description = widget.poster.description;
      photoUrl = widget.poster.photoProfile;
      uid = widget.poster.uid;
      //cat = widget.poster.categorie.cat;
    }
    getProfilPosts();
  }

  getProfilPosts() async {
    try {
      if (widget.poster == null) {
        posts = await postService.getProfilPosts(uid, postCount);
        postCount = posts.length;
      } else {
        posts = await postService.getProfilPosts(uid, postCount);
        postCount = posts.length;
      }
      setState(() {
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }

  handleProfilLikes() async {
    bool _isLiked = (widget.poster.profilLikes[proID] == true);

    if (_isLiked) {
      try {
        await talentService.likeTalentProfil(
            proID, widget.poster.uid, false);
        setState(() {
          isLiked = false;
          widget.poster.profilLikes[proID] = false;
        });
      } catch (e) {
        print(e);
      }
    } else if (!_isLiked) {
      try {
        await talentService.likeTalentProfil(
            proID, widget.poster.uid, true);
        setState(() {
          isLiked = true;
          widget.poster.profilLikes[proID] = true;
        });
      } catch (e) {
        print(e);
      }
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
            poster: widget.poster != null ? widget.poster : talent,
          )
      ],
    );
  }

  Widget profileView() {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.6,
          margin: widget.poster == null || talent == widget.poster
              ? EdgeInsets.only(bottom: 0)
              : EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  bottomLeft: const Radius.circular(5.0),
                  bottomRight: const Radius.circular(5.0))),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
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
                              fontSize: 25, fontWeight: FontWeight.bold)),
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
            Text('categorie',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)),
            SizedBox(
              height: 8,
            ),
            if (pro != null)
              RaisedButton.icon(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    if(pro !=null && widget.poster != null) handleProfilLikes();
                  },
                  icon: Icon(Icons.thumb_up,
                      color: isLiked == false ? Colors.white : Colors.blueGrey),
                  label: Text(
                    'J\'aime',
                    style: TextStyle(
                        color:
                            isLiked == false ? Colors.white : Colors.blueGrey),
                  )),
            Text(widget.poster !=null  ? ' ' +  widget.poster.getLikesCount().toString() + ' J\'aimes'
            : ' ' +  talent.getLikesCount().toString() + ' J\'aimes',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ]),
        ),
        if (widget.poster == null || talent == widget.poster)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
              )
            ],
          ),
        buildProfilPost()
      ],
    );
  }

 Widget floatButtons(){
   // var icon=Icons.favorite_border;
   switch (widget.visitor) {
     case UserType.talent:
      return null;
       break;
     case UserType.professionnel:
        return  FloatingActionButton(
                backgroundColor: Colors.white,
                child: Icon(Icons.favorite_border,color: Colors.redAccent,),
                onPressed: (){
                  setState(() {
                  //  icon=Icons.favorite;
                  });
                },
               );
       break;
     case UserType.admin:
       return  FloatingActionButton(
                backgroundColor: Colors.redAccent,
                child: Icon(Icons.delete_forever),
                
                onPressed: (){
                },
               );
       break;
       default:return null;
   }
     
   
    
  }


  @override
  Widget build(BuildContext context) {
    if(widget.poster != null) isLiked = (widget.poster.profilLikes[proID] == true);

    return Scaffold(
     
       floatingActionButton:widget.visitor==UserType.admin?floatButtons():null ,
     
        backgroundColor: Colors.grey[200],
        appBar: widget.poster == null || talent == widget.poster
            ? header(context, "profil", 'Artness')
            : AppBar(
                title: Text('Profile'),
              ),
        body: isWaiting ? circularProgress() : profileView());
  }








  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.delete_sweep),
              Text('Attention!!!'),
            ],
          ),
          content: Container(
            padding: EdgeInsets.all(7),
            child:Text('Etes-vous sure?') ,
            ),
          
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Oui, je suis sur",style: TextStyle(
                color:Colors.red
              ),),
              onPressed: () {
                TalentService().deleteTalent(talent.uid);
              }),
             FlatButton(
              child: new Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             
          ],
        );
      },
    );
  }
  }