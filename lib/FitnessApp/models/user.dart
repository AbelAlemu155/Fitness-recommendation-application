import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class User {
  String url;
  String username;
  String member_since;
  String last_seen;
  String posts_url;
  int post_count;
  String _token = '';
  String role;
  String image_url;

  set token(String token) {
    this._token = token;
  }

  String get token {
    return this._token;
  }

  User(
      {required this.url,
      required this.username,
      required this.member_since,
      required this.last_seen,
      required this.posts_url,
      required this.post_count,
      required this.role,
      required this.image_url
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        url: json['url'],
        username: json['username'],
        member_since: json['member_since'],
        last_seen: json['last_seen'],
        posts_url: json['posts_url'],
        post_count: json['post_count'],
        role: json['role'],
        image_url: json['image_url']
        );
  }
}
