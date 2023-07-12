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

  // Add a factory constructor to convert a map to a User object
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['Id'],
      name: map['Name'],
      email: map['Email'],
      password: map['Password'],
      role: map['Role'],
    );
  }

  // Add a method to convert the User object to a map
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
