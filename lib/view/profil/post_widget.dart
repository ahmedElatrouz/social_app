import 'package:flutter/material.dart';
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/view/shared/constants.dart';

class PostWidget extends StatefulWidget {
  final Talent talent;
  final Post post;
  PostWidget({@required this.talent, @required this.post});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
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
         // Image.network(widget.post.photoUrl),
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
              onTap: () => print('liking post'),
              child: Icon(
                Icons.favorite_border,
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
    return Column(
      children: <Widget>[
        buildPostHeader(),
        buildPostImage(),
        buildPostFooter(),
      ],
    );
  }
}
