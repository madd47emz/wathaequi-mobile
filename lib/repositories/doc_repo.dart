import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wathaequi/views/res/colors.dart';

import '../models/Paper.dart';

class DocRepo {
  Paper fromJson(Map<String, dynamic> json) {
    return Paper(
        name: json['name'],
        type: json['type'],
        expiration: DateTime.parse(json['expiration']));
  }

  Stream<List<Paper>>? getPapers() async* {
    final SharedPreferences cashe = await SharedPreferences.getInstance();
    final String token = cashe.getString("token")!;
    final String nin = cashe.getString("nin")!;
    print(nin);

    Dio dio = Dio();
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Response response = await dio
          .get("$baseUrl/document/api/user/documents/$nin");
      List<Paper> papers = [];

      if (response.statusCode == 200) {
        response.data.forEach((v) {
          papers.add(fromJson(v));
        });
        //final papers = response.data.map((json) => fromJson(json)).toList();
        yield papers;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> downloadNaissance() async {
    final SharedPreferences cashe = await SharedPreferences.getInstance();
    final String token = cashe.getString("token")!;
    final String nin = cashe.getString("nin")!;

    Dio dio = Dio();
    dio.options.receiveTimeout = const Duration(seconds: 20);
    dio.options.connectTimeout = const Duration(seconds: 20);
    dio.options.headers['Authorization'] = 'Bearer $token';

    try {
      Directory? dir =
          await getExternalStorageDirectory();
      String filePath = '${dir!.path}/naissance.pdf';
      await dio.download(
          "$baseUrl/document/api/naissance/user/$nin", filePath);

      return filePath;
    } catch (e) {
      print(e);
    }

    return "error";
  }
}
