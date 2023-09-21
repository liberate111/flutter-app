class Datum {
  int? id;
  String? title;
  String? detail;
  String? date;
  int? view;
  String? picture;

  Datum({
    this.id,
    this.title,
    this.detail,
    this.date,
    this.view,
    this.picture,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        title: json['title'] as String?,
        detail: json['detail'] as String?,
        date: json['date'] as String?,
        view: json['view'] as int?,
        picture: json['picture'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'detail': detail,
        'date': date,
        'view': view,
        'picture': picture,
      };
}
