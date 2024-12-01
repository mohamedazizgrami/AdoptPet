import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'model/Dog.dart';
import 'FakeDogDatabase.dart';  // Make sure this imports the correct dog list

class DogListScreen extends StatelessWidget {
  const DogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dogs for Adoption"),
      ),
      body: ListView.builder(
        itemCount: dogList.length,
        itemBuilder: (context, index) {
          final dog = dogList[index];
          return GestureDetector(
            onTap: () {
              context.push('/details/${dog.id}');
            },
            child: DogCard(dog: dog),
          );
        },
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;

  const DogCard({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              dog.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dog.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${dog.age} yrs | ${dog.color}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 14),
                    Text(
                      "${dog.location} away",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: dog.gender == 'Male' ? Colors.blue[50] : Colors.pink[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              dog.gender,
              style: TextStyle(
                color: dog.gender == 'Male' ? Colors.blue : Colors.pink,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'DogDetailScreen.dart';
// import 'model/Dog.dart';

// class DogListScreen extends StatefulWidget {
//   const DogListScreen({super.key});

//   @override
//   _DogListScreenState createState() => _DogListScreenState();
// }

// class _DogListScreenState extends State<DogListScreen> {
//   late Future<List<Dog>> dogs;

//   Future<List<Dog>> fetchDogs() async {
//     final response = await http.get(Uri.parse('http://localhost:3000/dogs'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body);
//       return data.map((dogData) => Dog.fromJson(dogData)).toList();
//     } else {
//       throw Exception('Failed to load dogs');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     dogs = fetchDogs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dogs for Adoption"),
//       ),
//       body: FutureBuilder<List<Dog>>(
//         future: dogs,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
//             final dogList = snapshot.data!;
//             return ListView.builder(
//               itemCount: dogList.length,
//               itemBuilder: (context, index) {
//                 final dog = dogList[index];
//                 return GestureDetector(
//                   onTap: () {
//                     context.push('/details/${dog.id}');
//                   },
//                   child: DogCard(dog: dog),
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No dogs available'));
//           }
//         },
//       ),
//     );
//   }
// }
