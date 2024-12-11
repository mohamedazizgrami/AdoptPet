class Owner {
  int id;
  String name;
  String bio;
  String image;

  Owner({
    required this.id,
    required this.name,
    required this.bio,
    required this.image,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] as int,
      name: json['name'] as String,
      bio: json['bio'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'bio': bio,
      'image': image,
    };
  }
}
