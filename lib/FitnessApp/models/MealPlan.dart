import 'package:equatable/equatable.dart';

class Breakfast extends Equatable {
  String name;
  String description;
  double calories;
  int category;
  String ingredients;
  double carb;
  double protein;
  double fat;
  String duration;
  String image_url;
  int id;
  Breakfast(
      {required this.name,
      required this.description,
      required this.calories,
      required this.category,
      required this.carb,
      required this.duration,
      required this.fat,
      required this.ingredients,
      required this.protein,
      required this.image_url,
      required this.id});

  factory Breakfast.fromJson(Map<String, dynamic> json) {
    String ingr = json['ingredients'] != null ? json['ingredients'] : ' ';
    String dur = json['duration'] != null ? json['duration'] : ' ';
    return Breakfast(
        name: json['name'],
        description: json['description'],
        calories: json['calories'],
        category: json['category'],
        ingredients: ingr,
        carb: json['carb'],
        protein: json['protein'],
        fat: json['fat'],
        duration: dur,
        image_url: json['image_url'],
        id: json['id']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Lunch extends Equatable {
  String name;
  String description;
  double calories;
  int category;
  String ingredients;
  double carb;
  double protein;
  double fat;
  String duration;
  String image_url;
  int id;
  Lunch(
      {required this.name,
      required this.description,
      required this.calories,
      required this.category,
      required this.carb,
      required this.duration,
      required this.fat,
      required this.ingredients,
      required this.protein,
      required this.image_url,
      required this.id});

  factory Lunch.fromJson(Map<String, dynamic> json) {
    String ingr = json['ingredients'] != null ? json['ingredients'] : ' ';
    String dur = json['duration'] != null ? json['duration'] : ' ';
    return Lunch(
        name: json['name'],
        description: json['description'],
        calories: json['calories'],
        category: json['category'],
        ingredients: ingr,
        carb: json['carb'],
        protein: json['protein'],
        fat: json['fat'],
        duration: dur,
        image_url: json['image_url'],
        id: json['id']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Dinner extends Equatable {
  String name;
  String description;
  double calories;
  int category;
  String ingredients;
  double carb;
  double protein;
  double fat;
  String duration;
  String image_url;
  int id;
  Dinner(
      {required this.name,
      required this.description,
      required this.calories,
      required this.category,
      required this.carb,
      required this.duration,
      required this.fat,
      required this.ingredients,
      required this.protein,
      required this.image_url,
      required this.id});

  factory Dinner.fromJson(Map<String, dynamic> json) {
    String ingr = json['ingredients'] != null ? json['ingredients'] : ' ';
    String dur = json['duration'] != null ? json['duration'] : ' ';
    return Dinner(
        name: json['name'],
        description: json['description'],
        calories: json['calories'],
        category: json['category'],
        ingredients: ingr,
        carb: json['carb'],
        protein: json['protein'],
        fat: json['fat'],
        duration: dur,
        image_url: json['image_url'],
        id: json['id']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Snack extends Equatable {
  String name;
  String description;
  double calories;
  int category;
  String ingredients;
  double carb;
  double protein;
  double fat;
  String duration;
  String image_url;
  int id;

  Snack(
      {required this.id,
      required this.name,
      required this.description,
      required this.calories,
      required this.category,
      required this.carb,
      required this.duration,
      required this.fat,
      required this.ingredients,
      required this.protein,
      required this.image_url});

  factory Snack.fromJson(Map<String, dynamic> json) {
    String ingr = json['ingredients'] != null ? json['ingredients'] : ' ';
    String dur = json['duration'] != null ? json['duration'] : ' ';
    return Snack(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        calories: json['calories'],
        category: json['category'],
        ingredients: ingr,
        carb: json['carb'],
        protein: json['protein'],
        fat: json['fat'],
        duration: dur,
        image_url: json['image_url']);
  }
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
