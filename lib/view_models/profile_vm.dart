import 'package:wathaequi/models/Citizen.dart';
import 'package:wathaequi/repositories/profile_repo.dart';

class ProfileViewModel{
  late ProfileRepo _profileRepo;
  Stream<Citizen>? getProfile() {
    _profileRepo = ProfileRepo();
    return _profileRepo.getProfile();
  }
}