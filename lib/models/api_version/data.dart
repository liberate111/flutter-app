class Data {
  String? version;

  Data({this.version});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        version: json['version'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'version': version,
      };
}
