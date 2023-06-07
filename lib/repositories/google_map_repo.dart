import 'package:dio/dio.dart';

import '../models/Nearby.dart';

class MapRepo{
  Future<NearbyPlacesResponse?> getNearbyPlaces(double long, double lat) async {
    String url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$long,$lat&radius=10000&type=city_hall&key=AIzaSyDjx8L9TW6keKkHg64cczM9hNECQ8b_tcc";
    print(url);

    Dio dio = Dio();
    dio.options.receiveTimeout =  const Duration(seconds: 20);
    dio.options.connectTimeout =  const Duration(seconds: 20);
    try {

      var response = await dio.get(url);

      if (response.statusCode ==200) return NearbyPlacesResponse.fromJson(response.data);

      return null;

    } catch (e) {
      print(e);
    }
    return null;
  }
}