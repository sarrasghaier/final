import 'roles.dart';

class Users {
  final int? id;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? telephone;
  final String? createdAt;
  final String? updatedAt;
  final Roles? roles;

  Users({this.id, this.email, this.password, this.firstName,this.lastName,this.telephone, this.createdAt, this.updatedAt, this.roles});

  factory Users.fromJson(Map<String, dynamic> json) {

    return Users(
        id: json['id'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        telephone: json['phone'] as String,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        roles: Roles.fromJson(json['Role']));
  }

  @override
  String toString() {
    return 'Users{name: $firstName, email: $email}';
  }
}
