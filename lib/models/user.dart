class User {
  int? id;
  String? name;
  String? email;
  String? fname;
  String? path;
  String? role;
  String? school_name;
  String? status;

  User(
      {this.id,
      this.name,
      this.email,
      this.fname,
      this.path,
      this.role,
      this.school_name,
      this.status});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      fname: json['fname'],
      path: json['path'],
      role: json['role'],
      school_name: json['school_name'],
      status: json['status'],
    );
  }
}
