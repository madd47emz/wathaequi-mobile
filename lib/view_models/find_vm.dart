import 'package:geolocator/geolocator.dart';
import 'package:wathaequi/models/Nearby.dart';
import 'package:wathaequi/repositories/google_map_repo.dart';

class FindViewModel{
  MapRepo _repo = MapRepo();

  Future<NearbyPlacesResponse?> getCityHalls()async{
    Position? p = await determinePosition();

    return _repo.getNearbyPlaces(p!.latitude, p.longitude);
  }
  Future<Position?> determinePosition() async {
    LocationPermission permission =
    await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {

        final GeolocatorPlatform geolocator =
            GeolocatorPlatform.instance;
        Position position =
        await geolocator.getCurrentPosition(
            locationSettings: LocationSettings());
        return position;



      } catch (e) {
        print(e);
      }
      return null;
    }
  }
}