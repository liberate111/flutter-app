import 'data.dart';

class Account {
  String? message;
  int? statusCode;
  Data? data;

  Account({this.message, this.statusCode, this.data});

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        message: json['message'] as String?,
        statusCode: json['status_code'] as int?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'status_code': statusCode,
        'data': data?.toJson(),
      };
}
