class MovieCardModel {

  dynamic id;
  String image;
  String title;
  String year;
  String additional;
  bool isSelected;

  MovieCardModel({
    this.id = "",
    required this.image,
    required this.title,
    required this.year,
    required this.additional,
    this.isSelected = false,
  });

  static MovieCardModel fromjson(Map<String, dynamic> json) {
    return MovieCardModel(
        image: json['image'],
        additional: json['additional'],
        title: json['title'],
        year: json['year'],
        id: json['id'],
        isSelected: json['isSelected']);
  }

  Map<String, dynamic> tojson() {
    return {
      "id": id,
      "image": image,
      "title": title,
      "year": year,
      "additional": additional,
      "isSelected": isSelected,
    };
  }
}
