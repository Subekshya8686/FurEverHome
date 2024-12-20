import 'package:flutter/material.dart';
import 'package:furever_home/view/pet_profile_card_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of pet types and genders for the filters
  final List<String> petTypes = ['All', 'Dog', 'Cat'];
  final List<String> genders = ['All', 'Male', 'Female'];

  // Currently selected filters
  String selectedPetType = 'All';
  String selectedGender = 'All';

  // Dummy data for pet profiles (including pet type and gender)
  final List<Map<String, String>> pets = [
    {
      'name': 'Buddy',
      'description':
          'A friendly dog. Loves to play fetch. The ball is his favorite toy. Enemey of cats.',
      'image': 'dog1.png',
      'gender': 'male',
      'age': '2 years old',
      'type': 'Dog',
    },
    {
      'name': 'Kitty',
      'description': 'A cute cat',
      'image': 'dog2.png',
      'gender': 'female',
      'age': '1 year old',
      'type': 'Cat',
    },
    {
      'name': 'Charlie',
      'description': 'An energetic puppy',
      'image': 'dog3.png',
      'gender': 'male',
      'age': '6 months old',
      'type': 'Dog',
    },
    {
      'name': 'Milo',
      'description': 'A curious kitten',
      'image': 'dog3.png',
      'gender': 'male',
      'age': '8 months old',
      'type': 'Cat',
    },
    {
      'name': 'Luna',
      'description': 'A playful dog',
      'image': 'dog4.png',
      'gender': 'female',
      'age': '3 years old',
      'type': 'Dog',
    },
    {
      'name': 'Oliver',
      'description': 'A cute cat',
      'image': 'dog2.png',
      'gender': 'male',
      'age': '2 years old',
      'type': 'Cat',
    },
    {
      'name': 'Luna',
      'description': 'A playful dog',
      'image': 'dog5.png',
      'gender': 'female',
      'age': '3 years old',
      'type': 'Dog',
    },
    {
      'name': 'Oliver',
      'description': 'A cute cat',
      'image': 'cat1.png',
      'gender': 'male',
      'age': '2 years old',
      'type': 'Cat',
    },
    {
      'name': 'Buddy',
      'description':
          'A friendly dog. Loves to play fetch. The ball is his favorite toy. Enemey of cats.',
      'image': 'dog1.png',
      'gender': 'male',
      'age': '2 years old',
      'type': 'Dog',
    },
    {
      'name': 'Kitty',
      'description': 'A cute cat',
      'image': 'dog2.png',
      'gender': 'female',
      'age': '1 year old',
      'type': 'Cat',
    },
  ];

  // Filtered pets list based on selected filters
  List<Map<String, String>> get filteredPets {
    return pets.where((pet) {
      bool matchesPetType =
          selectedPetType == 'All' || pet['type'] == selectedPetType;
      bool matchesGender = selectedGender == 'All' ||
          pet['gender']?.toLowerCase() == selectedGender.toLowerCase();
      return matchesPetType && matchesGender;
    }).toList();
  }

  // Reset filters to default
  void resetFilters() {
    setState(() {
      selectedPetType = 'All';
      selectedGender = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine outline color based on filtering state
    Color outlineColor = (selectedPetType != 'All' || selectedGender != 'All')
        ? const Color(0xFF66AEA6)
        : Colors.grey;

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    double fontSize = isTablet ? 22 : 14;
    double filterWidth = isTablet ? screenWidth * 0.2 : screenWidth * 0.3;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Filter row (Pet type, Gender, Reset button)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pet Type Filter
                SizedBox(
                  width: filterWidth,
                  child: DropdownButtonFormField<String>(
                    value: selectedPetType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPetType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Pet Type',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: fontSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: outlineColor, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: outlineColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items:
                        petTypes.map<DropdownMenuItem<String>>((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 8), // Space between filters

                // Gender Filter
                SizedBox(
                  width: filterWidth,
                  child: DropdownButtonFormField<String>(
                    value: selectedGender,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedGender = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle:
                          TextStyle(color: Colors.black, fontSize: fontSize),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: outlineColor, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: outlineColor, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items:
                        genders.map<DropdownMenuItem<String>>((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 16), // Space between filters
                // Reset Button
                // ElevatedButton(
                //   onPressed: resetFilters,
                //   style: ElevatedButton.styleFrom(
                //     foregroundColor: Colors.white,
                //     backgroundColor: Colors.teal,
                //     // backgroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   // child: const Text('Reset'),
                //   child: const Icon(Icons.refresh),
                // ),
                OutlinedButton(
                  onPressed: resetFilters,
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: Colors.teal), // Teal border color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.teal, // Teal icon color
                  ),
                ),
              ],
            ),
          ),
        ),
        // Pet profile list view
        Expanded(
          // child: ListView.builder(
          //   itemCount: filteredPets.length,
          //   itemBuilder: (context, index) {
          //     final pet = filteredPets[index];
          //     return PetProfileCardView(
          //       name: pet['name']!,
          //       description: pet['description']!,
          //       image: pet['image']!,
          //       gender: pet['gender']!,
          //       age: pet['age']!,
          //     );
          //   },
          // ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                // Tablet: Fixed width for each card, multiple cards in a row
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: filteredPets.length,
                  itemBuilder: (context, index) {
                    final pet = filteredPets[index];
                    return PetProfileCardView(
                      name: pet['name']!,
                      description: pet['description']!,
                      image: pet['image']!,
                      gender: pet['gender']!,
                      age: pet['age']!,
                    );
                  },
                );
              } else {
                // Mobile: ListView (one card per row)
                return ListView.builder(
                  itemCount: filteredPets.length,
                  itemBuilder: (context, index) {
                    final pet = filteredPets[index];
                    return PetProfileCardView(
                      name: pet['name']!,
                      description: pet['description']!,
                      image: pet['image']!,
                      gender: pet['gender']!,
                      age: pet['age']!,
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
