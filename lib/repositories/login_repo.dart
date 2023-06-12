import 'package:dio/dio.dart' ;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/views/res/colors.dart';

class LoginRepo{
  Future<String> login(String nin, String password) async {
    final SharedPreferences cashe = await SharedPreferences.getInstance();

    Dio dio = Dio();
    dio.options.receiveTimeout =  const Duration(seconds: 20);
    dio.options.connectTimeout =  const Duration(seconds: 20);
    


    try {

      Response response = await dio.post("$baseUrl/auth/users/authenticate",data: {'username': nin, 'password': password});

      if (response.statusCode ==200) {
        cashe.setString("token", response.data);
        cashe.setString("nin", nin);
        cashe.setString("password", password);

        return response.data;}else{
      return "wrong email or password";}

    } catch (e) {
      print(e);
    }
    return "error connecting";
  }

}