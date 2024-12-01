import 'Owner.dart';

class Dog {
  final int id;
  final String name;
  final double age;
  final String gender;
  final String color;
  final double weight;
  final String location;
  final String image;
  final String about;
  final Owner owner;
  Dog(
    this.id,
    this.name,
    this.age,
    this.gender,
    this.color,
    this.weight,
    this.location,
    this.image,
    this.about,
    this.owner, 
  );
  // factory Dog.fromJson(Map<String, dynamic> json) {
  //   return Dog(
  //     id: json['_id'],
  //     name: json['name'],
  //     age: json['age'],
  //     gender: json['gender'],
  //     color: json['color'],
  //     weight: json['weight'],
  //     location: json['location'],
  //     image: json['image'],
  //     about: json['about'],
  //   );
  // }
}
