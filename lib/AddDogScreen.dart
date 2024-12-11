import 'package:adoptpet/model/Owner.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/Dog.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  _AddDogScreenState createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerBioController = TextEditingController();
  final TextEditingController ownerImageController = TextEditingController();

 Future<void> addDog(Dog dog) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/dogs'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'name': dog.name,
      'age': dog.age,
      'gender': dog.gender,
      'color': dog.color,
      'weight': dog.weight,
      'location': dog.location,
      'image': dog.image,
      'about': dog.about,
      'owner': {
        'name': dog.owner.name,
        'bio': dog.owner.bio,
        'image': dog.owner.image,
      }
    }),
  );

  if (response.statusCode == 201) {
    print('Dog added successfully');
  } else {
    throw Exception('Failed to add dog');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Dog"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s age' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: genderController,
                  decoration: const InputDecoration(labelText: 'Gender'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s gender' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: colorController,
                  decoration: const InputDecoration(labelText: 'Color'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s color' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s weight' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the dog\'s location' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the image URL' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: aboutController,
                  decoration: const InputDecoration(labelText: 'About'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter some details about the dog' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ownerNameController,
                  decoration: const InputDecoration(labelText: 'Owner Name'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the owner\'s name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ownerBioController,
                  decoration: const InputDecoration(labelText: 'Owner Bio'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the owner\'s bio' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: ownerImageController,
                  decoration: const InputDecoration(labelText: 'Owner Image URL'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Please enter the owner\'s image URL' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final dog = Dog(
                        id: 1,
                        name: nameController.text,
                        age: double.parse(ageController.text),
                        gender: genderController.text,
                        color: colorController.text,
                        weight: double.parse(weightController.text),
                        location: locationController.text,
                        image: imageController.text,
                        about: aboutController.text,
                        owner: Owner(
                          name: ownerNameController.text,
                          bio: ownerBioController.text,
                          image: ownerImageController.text,
                          id: 1, 
                        ),
                      );
                      addDog(dog);
                    }
                  },
                  child: const Text('Add Dog'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
