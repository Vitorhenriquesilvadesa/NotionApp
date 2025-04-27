import 'package:flutter/material.dart';

class User {
  final int? id;
  final String username;
  final String fullname;
  final String email;

  User({
    this.id,
    required this.fullname,
    required this.email,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullName'],
      email: json['email'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'fullname': fullname, 'email': email};
  }
}
