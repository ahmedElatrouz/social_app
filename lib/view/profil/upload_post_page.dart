import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/model/Talent.dart';
import 'package:social_app/services/postService.dart';
import 'package:social_app/view/shared/progress.dart';
import 'package:video_player/video_player.dart';




class UploadPost extends StatefulWidget {
  final Talent currentTalent;

  UploadPost({this.currentTalent});

  @override
  _UploadPostState createState() => _UploadPostState();
}



class _UploadPostState extends State<UploadPost> {

  PostService postService = PostService();
  File image;
  File video;

  VideoPlayerController videoPlayerController;

  TextEditingController captionController = TextEditingController();
  bool isUploading = false;

  addImage() async {
    Navigator.pop(context);
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      this.image = image;
    });
  }

  addVideo() async {
    Navigator.pop(context);
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    this.video = video;
    videoPlayerController = VideoPlayerController.file(video)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController.play();
      });
  }

  selectPost(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('create post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('add an image'),
                onPressed:()=> addImage(),
              ),
              SimpleDialogOption(
                child: Text('add a video'),
                onPressed:()=> addVideo(),
              )
            ],
          );
        });
  }

  Container buildSplashScrean() {
    return Container(
      color: Color(0xFF009688),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            'assets/images/upload.svg',
            height: 260,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text('Upload post',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              color: Colors.deepOrange,
              onPressed: () => selectPost(context),
            ),
          )
        ],
      ),
    );
  }


  clearPost() {
    setState(() {
      image = null;
    });
  }


  handleSubmit() async {

    setState(() {
      isUploading = true;
    });
    if(image != null){
    await postService.handleSubmitImage(image, captionController , widget.currentTalent.uid);
    }
    if(video != null){
      await postService.handleSubmitVideo(video, captionController , widget.currentTalent.uid);
    }
    captionController.clear();

    setState(() {
      image = null;
      isUploading = false;
    });
  }


  Scaffold buildUploadForm() {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: clearPost,
        ),
        title: Text('caption post', style: TextStyle(color: Colors.black)),
        actions: [
          FlatButton(
            child: Text('Post',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            onPressed: isUploading ? null : () => handleSubmit(),
          )
        ],
      ),

      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(''),
          if (image != null)
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (video != null)
            videoPlayerController.value.initialized
                ? Container(
                    //height: 300,
                    // width: MediaQuery.of(context).size.width * 0.8,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: videoPlayerController.value.aspectRatio,
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                  )
                : Container(),


          SizedBox(height: 8,),

          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
            ),
            title: Container(
              width: 250,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: "write a discription...",
                  border: InputBorder.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return image == null && video == null
        ? buildSplashScrean()
        : buildUploadForm();
  }
}
