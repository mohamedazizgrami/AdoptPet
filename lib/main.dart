import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'DogListScreen.dart';
import 'DogDetailScreen.dart';
import 'FakeDogDatabase.dart';

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
        final dog = dogList.firstWhere((dog) => dog.id == id);
        return DogDetailScreen(dog: dog);
      },
    ),
  ],
);
