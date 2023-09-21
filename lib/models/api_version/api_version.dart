import 'data.dart';

class ApiVersion {
  String? message;
  Data? data;
  int? statusCode;

  ApiVersion({this.message, this.data, this.statusCode});

  factory ApiVersion.fromJson(Map<String, dynamic> json) => ApiVersion(
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        statusCode: json['status_code'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.toJson(),
        'status_code': statusCode,
      };
}
