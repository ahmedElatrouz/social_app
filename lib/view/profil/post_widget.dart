import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/profil/profil_page.dart';
import 'package:social_app/view/shared/custom_image.dart';

class PostWidget extends StatefulWidget {
  final Talent talent;
  final Post post;
  final Talent poster;

  PostWidget({
    this.poster,
    @required this.talent,
    @required this.post,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostService postService = PostService();
  TalentService talentService = TalentService();
  bool isLiked;
  Talent talent0 = Talent();
  String nom = '';
  String prenom = '';
  String photoProfil = '';

  checkTalent() async {
    talent0 = await talentService.getCurrentUser();
  }

  @override
  void initState() {
    checkTalent();
    photoProfil = widget.poster.photoProfile;
    nom = widget.poster.nom;
    prenom = widget.poster.prenom;
    super.initState();
  }

  handleLikePost() async {
    bool _isLiked = (widget.post.likes[talent0.uid] == true);

    if (_isLiked) {
      try {
        await postService.likeProfilPosts(
            talent0.uid, widget.post.postId, false);
        setState(() {
          isLiked = false;
          widget.post.likes[talent0.uid] = false;
        });
      } catch (e) {
        print(e);
      }
    } else if (!_isLiked) {
      try {
        await postService.likeProfilPosts(
            talent0.uid, widget.post.postId, true);
        setState(() {
          isLiked = true;
          widget.post.likes[talent0.uid] = true;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  goToProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilPage(
                  poster: widget.poster,
                )));
  }

  buildPostHeader() {
    return ListTile(
      leading: GestureDetector(
        onTap: () => goToProfile(),
        child: CircleAvatar(
          backgroundColor: Colors.red,
          backgroundImage: photoProfil != ''
              ? CachedNetworkImageProvider(photoProfil)
              : AssetImage('assets/images/user_icon.png'),
        ),
      ),
      title: GestureDetector(
        child: Text(
          nom + ' ' + prenom,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      subtitle: Text(widget.post.description),
      trailing: IconButton(
        onPressed: () => print('delete post'),
        icon: Icon(Icons.more_vert),
      ),
    );
  }

  buildPostImage() {
    return GestureDetector(
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width-30,
        color: Colors.grey,
        child: cachedNetworkImage(widget.post.photoUrl,context),),
    );
  }

  buildPostFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () => handleLikePost(),
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: 30,
          ),
        ),
        Container(
          child: Text(
            widget.post.getLikesCount().toString() + ' likes',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (widget.post.likes[talent0.uid] == true) ||
        (widget.post.likes[widget.talent.uid] == true);

    return Container(
      height: MediaQuery.of(context).size.height/2,
      margin: EdgeInsets.symmetric(horizontal:0, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.white, //Color(0xFFF0F0F0),
        border: Border.all(color: Colors.blueGrey, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10,vertical:0),
        child: InkWell(
          child: Column(
            children: <Widget>[
              Expanded(child: buildPostHeader(),),
              Expanded(flex: 2,child: buildPostImage(),),
              SizedBox(
                height: 5,
              ),
              buildPostFooter(),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
