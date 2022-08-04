import 'dart:ffi';

class UserInfos {
  String? uid;
  String? ville;
  List? type;
  bool? upgraded;
  int? bookInShop;

  UserInfos({this.uid, this.ville, this.type, this.upgraded, this.bookInShop});

  //receiving data from server
  factory UserInfos.fromMap(map) {
    return UserInfos(
      uid: map['uid'],
      ville: map['ville'],
      type: map['type'],
      upgraded: map['upgraded'],
      bookInShop: map['bookInShop'],

    );
  }

  //envoyer la data a notre server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'ville': ville,
      'type': type,
      'upgraded': upgraded,
      'bookInShop': bookInShop,

    };
  }

  //on a besoin de créer cette map
  UserInfos.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    ville = json['ville'];
    type = json['type'];
    upgraded = json['upgraded'];
    bookInShop = json['bookInShop'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['ville'] = this.ville;
    data['type'] = this.type;
    data['upgraded'] = this.upgraded;
    data['bookInShop'] = this.bookInShop;

    return data;
  }
}