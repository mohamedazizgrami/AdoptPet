import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'DogListScreen.dart';
import 'DogDetailScreen.dart';
import 'AddDogScreen.dart';
import 'model/Dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AdoPet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

// Configuration GoRouter
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DogListScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return FutureBuilder<Dog>(
          future: fetchDogById(id), 
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur : ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Chien introuvable.'));
            } else {
              return DogDetailScreen(dog: snapshot.data!);
            }
          },
        );
      },
    ),
    GoRoute(
      path: '/add-dog',
      builder: (context, state) => const AddDogScreen(),
    ),
  ],
);

// Fonction pour récupérer un chien par ID depuis l'API
Future<Dog> fetchDogById(int id) async {
  var http;
  final response = await http.get(Uri.parse('http://localhost:3000/dogs/$id'));

  if (response.statusCode == 200) {
    return Dog.fromJson(json.decode(response.body));
  } else {
    throw Exception('Impossible de récupérer les détails du chien.');
  }
}
