class User {
  final String email;
  final String id;
  final String login;
  final String phone;
  final String role;

  const User({
    required this.email,
    required this.id,
    required this.login,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      login: json['login'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}