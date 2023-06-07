class Citizen {
  late String _nin;
  late String _password;

  String get nin => _nin;

  set nin(String value) {
    _nin = value;
  }

  String? nationality;
  String? fullNameLat;
  String? dayra;
  String? commune;
  String? wilaya;
  String? birthdate;
  String? gender;
  String? status;

  Citizen(

      );


  fromJson(Map<String, dynamic> json) {
    nationality = json['nationality'];
    fullNameLat = json['fullNameLat'];
    dayra = json['dayra'];
    commune = json['commune'];
    wilaya = json['wilaya'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    status = json['status'];
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }
}
