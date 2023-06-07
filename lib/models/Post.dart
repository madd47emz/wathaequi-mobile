class Post {
  int? idPublication;
  String? content;
  String? picture;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPublication'] = this.idPublication;
    data['content'] = this.content;
    data['picture'] = this.picture;
    data['adresse'] = this.adresse;
    data['commune'] = this.commune;
    data['wilaya'] = this.wilaya;
    data['datePublication'] = this.datePublication;
    if (this.reponces != null) {
      data['reponces'] = this.reponces!.map((v) => v.toJson()).toList();
    }
    data['fullNameCitizen'] = this.fullNameCitizen;
    return data;
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateReply'] = this.dateReply;
    data['content'] = this.content;
    return data;
  }
}
