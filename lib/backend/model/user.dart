class User {
  User({required this.email, required this.username, required this.password});

  String email;
  String username;
  String password;

  factory User.fromJSON(Map<String, dynamic> json) {
    return User(
      email: json["email"],
      password: json["password"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> json = {};

    json["email"] = email;
    json["username"] = username;
    json["password"] = password;

    return json;
  }
}
