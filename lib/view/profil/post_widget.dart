import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/services/talentService.dart';
import 'package:social_app/view/shared/custom_image.dart';

class PostWidget extends StatefulWidget {
  final Talent talent;
  final Post post;

  PostWidget({
    @required this.talent,
    @required this.post,
  });

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostService postService = PostService();
  TalentService talentService = TalentService();
  List<Talent> talents = [];
  bool isLiked;
  Talent talent0 = Talent();

  checkTalent() async {
    talent0 = await talentService.getCurrentUser();
    }


  @override
  void initState() {
    print(isLiked);
    checkTalent();
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
        print(widget.post.likes);
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
        print(widget.post.likes);
      } catch (e) {
        print(e);
      }
    }
  }

  buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: widget.talent.photo != ''
            ? CachedNetworkImageProvider(widget.talent.photo)
            : AssetImage('assets/images/ahmed.jpg'),
      ),
      title: GestureDetector(
        child: Text(
          widget.talent.nom + ' ' + widget.talent.prenom,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
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
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          cachedNetworkImage(widget.post.photoUrl),
        ],
      ),
    );
  }

  buildPostFooter() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => handleLikePost(),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 30,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              child: Text(
                widget.post.getLikesCount().toString() + ' likes',
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
    isLiked = (widget.post.likes[talent0.uid] == true);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: Colors.grey[100], //Color(0xFFF0F0F0),
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          child: Column(
            children: <Widget>[
              buildPostHeader(),
              buildPostImage(),
              buildPostFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
