import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/view/shared/custom_image.dart';


class PostWidget extends StatefulWidget {
  final Talent talent;
  final Post post;

  PostWidget({@required this.talent, @required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  PostService postService = PostService();
  bool isLiked;

  handleLikePost() async {
    bool _isliked = widget.post.likes[widget.talent.uid] == true;
    String talentId = widget.talent.uid;
    String postId = widget.post.postId;

    if (_isliked) {
      try {
        await postService.likeProfilPosts(talentId, postId, false);
        setState(() {
          isLiked = false;
          widget.post.likes[widget.talent.uid] = false;
        });
        print(widget.post.likes);
      } 
      catch (e) {
        print(e);
        print('over here');
      }
    } 
    
    else if(!_isliked) {
      try {
        await postService.likeProfilPosts(talentId, postId, true);
        setState(() {
          isLiked = true;
          widget.post.likes[widget.talent.uid] = true;
        });
         print(widget.post.likes);
      } catch (e) {
        print(e);
        print('over here 2');
      }
    }
  }

  buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
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
   isLiked = (widget.post.likes[widget.talent.uid] == true);

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
