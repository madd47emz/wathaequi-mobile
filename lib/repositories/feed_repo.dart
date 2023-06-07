

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/models/Post.dart';

class FeedRepo{
  String name = '';
  Future<String> createPost(String content,String path,String address, String wilaya,String commune) async {
    final SharedPreferences cashe = await SharedPreferences.getInstance();
    final String token = cashe.getString("token")!;
    final String nin = cashe.getString("nin")!;
    name = cashe.getString("name")!;

    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var date = DateTime.now().toString().split(" ")[0];
      print(date);
      var formData = FormData.fromMap({
        'typePublication': 'Signalement',
        'content': content,
        'picture': await MultipartFile.fromFile(path,
            filename: 'image.jpg'),
        'adresse': address,
        'commune': commune,
        'wilaya': wilaya,
        'datePublication': date,
        'fullNameCitizen': name,
        'idCitizen': nin,
      });

      var response = await dio.post(
        'http://192.168.197.208:7778/forum/ms-participation-citoyen/publications',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Publication created successfully.');
        return 'Publication created successfully.';
      } else {
        print('Failed to create publication: ${response.data}');
        return 'Failed to create publication';
      }
    } catch (e) {
      print('Failed to create publication: $e');
      return "error";
    }}



  Stream<List<Post>>? getPosts() async* {
    final SharedPreferences cashe = await SharedPreferences.getInstance();
    final String token = cashe.getString("token")!;
    final String nin = cashe.getString("nin")!;

    Dio dio = Dio();
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await dio
          .get("localhost:7778/forum/ms-participation-citoyen/citizen/$nin/signalements");
      List<Post> posts = [];

      if (response.statusCode == 200) {
        response.data.forEach((v) {
          posts.add((Post.fromJson(v)));
        });
        yield posts;
      }
    } catch (e) {
      print(e);
    }
  }

  }









