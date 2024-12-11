import 'Owner.dart';

class Dog {
  int id; // L'ID doit être inclus et initialisé dans fromJson
  String name;
  double age;
  String gender;
  String color;
  double weight;
  String location;
  String image;
  String about;
  Owner owner;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.color,
    required this.weight,
    required this.location,
    required this.image,
    required this.about,
    required this.owner,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
      id: json['id'] as int, 
      name: json['name'] as String,
      age: (json['age'] as num).toDouble(), 
      gender: json['gender'] as String,
      color: json['color'] as String,
      weight: (json['weight'] as num).toDouble(),
      location: json['location'] as String,
      image: json['image'] as String,
      about: json['about'] as String,
      owner: Owner.fromJson(json['owner']),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'color': color,
      'weight': weight,
      'location': location,
      'image': image,
      'about': about,
      'owner': owner.toJson(), // Convertir Owner en JSON
    };
  }
}
