class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.role});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['Id'],
      name: map['Name'],
      email: map['Email'],
      password: map['Password'],
      role: map['Role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Name': name,
      'Email': email,
      'Password': password,
      'Role': role,
    };
  }
}
