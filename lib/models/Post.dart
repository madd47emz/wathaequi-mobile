class Post {
  int? idPublication;
  String? content;
  dynamic picture;
  String? adresse;
  String? commune;
  String? wilaya;
  String? datePublication;
  List<Reponces>? reponces;
  String? fullNameCitizen;

  Post(
      {this.idPublication,
        this.content,
        this.picture,
        this.adresse,
        this.commune,
        this.wilaya,
        this.datePublication,
        this.reponces,
        this.fullNameCitizen,
        });

  Post.fromJson(Map<String, dynamic> json) {
    idPublication = json['idPublication'];
    content = json['content'];
    picture = json['picture'];
    adresse = json['adresse'];
    commune = json['commune'];
    wilaya = json['wilaya'];
    datePublication = json['datePublication'];
    if (json['reponces'] != null) {
      reponces = <Reponces>[];
      json['reponces'].forEach((v) {
        reponces!.add(Reponces.fromJson(v));
      });
    }
    fullNameCitizen = json['fullNameCitizen'];
  }


}

class Reponces {
  String? dateReply;
  String? content;

  Reponces({this.dateReply,this.content});

  Reponces.fromJson(Map<String, dynamic> json) {
    dateReply = json['dateReply'];
    content = json['content'];
  }
}
