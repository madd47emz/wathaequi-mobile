import 'package:wathaequi/models/Post.dart';
import 'package:wathaequi/repositories/feed_repo.dart';

class FeedViewModel{
  FeedRepo _feedRepo = FeedRepo();
  Stream<List<Post>>? getPosts() {

    return _feedRepo.getPosts();
  }
}