import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String url;
  final String title;
  final String body;
  final String body_html;
  final String timestamp;
  final String author_url;
  final String image_url;

  Blog(
      {required this.url,
      required this.body,
      required this.body_html,
      required this.timestamp,
      required this.author_url,
      required this.image_url,
      required this.title});

  factory Blog.fromJson(Map<String, dynamic> json) {
    String htmlbody = json['body_html'] ?? '';
    String image_url = json['image_url'] == null ? '' : json['image_url'];
    return Blog(
        url: json['url'],
        body: json['body'],
        body_html: htmlbody,
        timestamp: json['timestamp'],
        author_url: json['author_url'],
        image_url: image_url,
        
        title: json['title']);
  }

  @override
  // TODO: implement props
  List<Object> get props => [
        this.url,
        this.body,
        this.body_html,
        this.timestamp,
        this.author_url,
        this.image_url
      ];

  @override
  String toString() => 'Blog { body: $body, url: $url }';
}
