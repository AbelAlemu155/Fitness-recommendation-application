import 'package:flutter/material.dart';

class Data {
  // for ordering in the graph
  final int id;
  final String name;
  double y;
  final Color color;

  Data({
    required this.name,
    required this.id,
    this.y = 0,
    required this.color,
  });
}
