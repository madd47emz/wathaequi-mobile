import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/views/res/colors.dart';

import '../models/Citizen.dart';

class ProfileRepo{
  Stream<Citizen>? getProfile() async* {
    Citizen citizen = Citizen();
    final SharedPreferences cashe = await SharedPreferences.getInstance();
    final String token = cashe.getString("token")!;
    print(token);
    citizen.nin=cashe.getString("nin")!;
    var nin =cashe.getString("nin")!;
    print(cashe.getString("nin"));
    citizen.password=cashe.getString("password")!;
    print(cashe.getString("password"));
    
    Dio dio = Dio();
    dio.options.receiveTimeout =  const Duration(seconds: 20);
    dio.options.connectTimeout =  const Duration(seconds: 20);
    dio.options.headers['Authorization'] = 'Bearer $token';



    try {

      Response response =  await dio.get("$baseUrl/auth/users/profile/$nin");

      if (response.statusCode ==200) {
        citizen.fromJson(response.data);
        cashe.setString("name", citizen.fullNameLat!);

        yield citizen;}

    } catch (e) {
      print(e);
    }
  }





  }
