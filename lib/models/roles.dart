
class Roles {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  Roles({this.id, this.name, this.createdAt, this.updatedAt});
  // Roles({this.id, this.roleName, this.roleDescription, this.createdAt, this.updatedAt});

  factory Roles.fromJson(Map<String, dynamic> json) {

    return Roles(
        id: json['id'] as int,
        name: json['name'] as String,
        createdAt: json['createdAt'] as String,
        updatedAt: json['updatedAt'] as String,
        );
  }

  @override
  String toString() {
    return 'Roles{role: $name}';
  }
}
