
import 'package:social_app/model/Post.dart';
import 'package:social_app/model/Talent.dart';
 
abstract class PostRepository {
  Future<int> createPost(Post post); 
  Future<int> updatePost(Post post);
  Future<int> deletePost(String id);
  Future<List<Post>> searchByUser(Talent talent);
  handleSubmitImage(image, captionController,currentTalentUid);
  handleSubmitVideo(video, captionController,currentTalentUid);
  Future<List<Post>> getProfilPosts(talentId , postCount);
  void likePosts(cueentUserId, postId, bool like);
}