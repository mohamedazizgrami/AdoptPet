import 'package:adoptpet/DogCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/Dog.dart'; 

class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  _DogListScreenState createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  late Future<List<Dog>> dogs;

  Future<List<Dog>> fetchDogs() async {
    final response = await http.get(Uri.parse('http://localhost:3000/dogs'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((dogData) => Dog.fromJson(dogData)).toList();
    } else {
      throw Exception('Failed to load dogs');
    }
  }

  @override
  void initState() {
    super.initState();
    dogs = fetchDogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dogs for Adoption"),
      ),
      body: FutureBuilder<List<Dog>>(
        future: dogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final dogList = snapshot.data!;
            return ListView.builder(
              itemCount: dogList.length,
              itemBuilder: (context, index) {
                final dog = dogList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to dog details screen
                  },
                  child: DogCard(dog: dog),
                );
              },
            );
          } else {
            return const Center(child: Text('No dogs available'));
          }
        },
      ),
    );
  }
}
