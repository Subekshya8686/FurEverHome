import 'package:flutter/material.dart';

class PetProfileCardView extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final String gender;
  final String age;

  const PetProfileCardView({
    super.key,
    required this.name,
    required this.description,
    required this.image,
    required this.gender,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    IconData genderIcon =
        gender.toLowerCase() == 'male' ? Icons.male : Icons.female;

    Color genderColor =
        gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink;

    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    double fontSize = isTablet ? 20 : 14;

    return Card(
      margin: const EdgeInsets.all(14.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // Rounded corners for the card
      ),
      child: Container(
        constraints: const BoxConstraints(maxHeight: 140),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage("assets/images/$image"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16), // Spacing between avatar and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: fontSize, // Dynamic font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8), // Space between name and icon
                        Icon(
                          genderIcon,
                          color: genderColor,
                          size: isTablet ? 28 : 20, // Dynamic icon size
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      age,
                      style: TextStyle(
                        fontSize: fontSize, // Dynamic font size
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: fontSize, // Dynamic font size
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Read More',
                        style: TextStyle(
                          fontSize: fontSize,
                          color: const Color(0xFF66AEA6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
