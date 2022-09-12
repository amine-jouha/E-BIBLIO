import 'dart:ffi';

class BookFormShop {
  String? uid;
  String? title;
  String? author;
  String? numPage;
  String? dateBook;
  String? price;
  bool? isSave;
  String? condition;
  String? description;

  BookFormShop({this.uid, this.title, this.author, this.dateBook, this.numPage, this.description, this.condition, this.price, this.isSave});

  //receiving data from server
  factory BookFormShop.fromMap(map) {
    return BookFormShop(
      uid: map['uid'],
      title: map['title'],
      author: map['author'],
      numPage: map['numPage'],
      dateBook: map['dateBook'],
      price: map['price'],
      isSave: map['isSave'],
      condition: map['condition'],
      description: map['description'],

    );
  }

  //envoyer la data a notre server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'author': author,
      'numPage': numPage,
      'dateBook': dateBook,
      'price': price,
      'isSave': isSave,
      'condition': condition,
      'description': description

    };
  }

  //on a besoin de créer cette map
  BookFormShop.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    title = json['title'];
    author = json['author'];
    numPage = json['numPage'];
    dateBook = json['dateBook'];
    price = json['price'];
    isSave = json['isSave'];
    condition = json['condition'];
    description = json['description'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['title'] = this.title;
    data['author'] = this.author;
    data['numPage'] = this.numPage;
    data['dateBook'] = this.dateBook;
    data['price'] = this.price;
    data['isSave'] = this.isSave;
    data['condition'] = this.condition;
    data['description'] = this.description;

    return data;
  }
}