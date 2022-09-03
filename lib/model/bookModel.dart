class BookModel {
  String? id, title, subtitle, description, author, thumbnail, bookUrl, pageCount, averageRating, publishedDate;

  BookModel({this.id, this.title, this.subtitle, this.description, this.author, this.thumbnail, this.bookUrl, this.publishedDate, this.pageCount, this.averageRating});

  factory BookModel.fromApi(Map<String, dynamic> data) {

    String getThumbnailSafety(Map<String, dynamic> data) {
      final imageLinks = data['volumeInfo']['imageLinks'];
      if (imageLinks != null && imageLinks['thumbnail'] != null) {
        return imageLinks['thumbnail'];
      } else {
        return "https://i.pinimg.com/736x/aa/04/0e/aa040e0a41583d896b20f40da23d5f4e.jpg";
      }
    }

    return BookModel(
        id: data['id'],
        title: data['volumeInfo']['title'],
        author: data['volumeInfo']['authors'].toString(),
        pageCount: data['volumeInfo']['pageCount'].toString(),
        averageRating: data['volumeInfo']['averageRating'].toString(),
        publishedDate: data['volumeInfo']['publishedDate'].toString(),
        description: data['volumeInfo']['description'],
        subtitle: data['volumeInfo']['subtitle'],
        thumbnail: getThumbnailSafety(data),
        // thumbnail: getThumbnailSafety(data).replaceAll("http", "https"),
        bookUrl: data['volumeInfo']['previewLink']);
  }
}
