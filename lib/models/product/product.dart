import 'datum.dart';
import 'meta.dart';

class Product {
  List<Datum>? data;
  Meta? meta;

  Product({this.data, this.meta});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((e) => e.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}
