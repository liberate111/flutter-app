class Meta {
  String? status;
  int? statusCode;

  Meta({this.status, this.statusCode});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        status: json['status'] as String?,
        statusCode: json['status_code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'status_code': statusCode,
      };
}
