import 'package:flutter/material.dart';
import 'model/Dog.dart';
import 'DogDetailScreen.dart'; // Import the DogDetailScreen

class DogCard extends StatelessWidget {
  final Dog dog;

  const DogCard({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            dog.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported, size: 50);
            },
          ),
        ),
        title: Text(
          dog.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          dog.about,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          // Navigate to the DogDetailScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DogDetailScreen(dog: dog),
            ),
          );
        },
      ),
    );
  }
}
