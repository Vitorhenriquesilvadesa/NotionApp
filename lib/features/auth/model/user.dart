class User {
  final String username;
  final String name;
  final String fullname;
  final String password;
  final User email;

  User(
    this.name,
    this.fullname,
    this.password,
    this.email, {
    required this.username,
  });
}
