class Photo {
  final int id;
  final String title;
  final String url;

  Photo({this.id, this.title, this.url});

  factory Photo.fromJson(Map json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}
