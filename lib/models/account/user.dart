class User {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? dob;
  String? role;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.dob,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        dob: json['dob'] as String?,
        role: json['role'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'email_verified_at': emailVerifiedAt,
        'dob': dob,
        'role': role,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
