import 'package:wathaequi/repositories/feed_repo.dart';

class CreatePostViewModel{
 late FeedRepo _feedRepo = FeedRepo();
 Future<String> createPost(String content,String path,String address, String wilaya,String commune) async{
   return await _feedRepo.createPost(content, path, address, wilaya, commune);
 }

}