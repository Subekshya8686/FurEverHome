import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:sensors_plus/sensors_plus.dart';

class PetDetailScreen extends StatefulWidget {
  final PetEntity pet;

  const PetDetailScreen({Key? key, required this.pet}) : super(key: key);

  @override
  _PetDetailScreenState createState() => _PetDetailScreenState();
}

class _PetDetailScreenState extends State<PetDetailScreen> {
  bool isFostering = false;

  void goBackToPetList() {
    // This is where you handle state management for going back
    context.read<HomeCubit>().goBackToPetList();
  }

  @override
  void initState() {
    super.initState();

    // Listen for shake gesture using accelerometerEventStream
    accelerometerEventStream().listen((AccelerometerEvent event) {
      if (_isShakeDetected(event)) {
        goBackToPetList();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isShakeDetected(AccelerometerEvent event) {
    // You can adjust the threshold value based on how sensitive you want the shake detection to be
    const double shakeThreshold = 10.0;

    // Check if the acceleration exceeds the threshold, indicating a shake
    return event.x.abs() > shakeThreshold ||
        event.y.abs() > shakeThreshold ||
        event.z.abs() > shakeThreshold;
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://10.0.2.2:5000/uploads/${widget.pet.photo}';
    // String imageUrl = 'http://192.168.1.5:5000/uploads/${widget.pet.photo}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            goBackToPetList(); // Navigate back to PetHomeScreen
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.pets,
                        size: 100, color: Colors.grey);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.pet.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.pet.age} years old',
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              widget.pet.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Add "Foster" and "Adopt" buttons side by side
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger the foster action and navigate
                    context.read<HomeCubit>().petFosterScreen(widget.pet);
                  },
                  child: const Text('Foster'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle adoption logic here
                    context.read<HomeCubit>().petAdoptionScreen(widget.pet);
                  },
                  child: const Text('Adopt'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14.0, horizontal: 40.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Display either the PetDetailFields or FosterFormPage

            const Text(
              "Pet Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            PetDetailFields(pet: widget.pet),
          ],
        ),
      ),
    );
  }
}

class PetDetailFields extends StatelessWidget {
  final PetEntity pet;

  const PetDetailFields({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (pet.type != null) _buildDetailRow('Type', pet.type!),
        if (pet.breed != null) _buildDetailRow('Breed', pet.breed),
        if (pet.weight != null) _buildDetailRow('Weight', '${pet.weight} kg'),
        if (pet.vaccinated != null)
          _buildDetailRow('Vaccinated', pet.vaccinated ? 'Yes' : 'No'),
        if (pet.specialNeeds != null)
          _buildDetailRow('Special Needs', pet.specialNeeds ? 'Yes' : 'No'),
        if (pet.healthDetails != null)
          _buildDetailRow('Health Details', pet.healthDetails!),
        if (pet.height != null) _buildDetailRow('Height', '${pet.height} cm'),
        if (pet.furType != null) _buildDetailRow('Fur Type', pet.furType!),
        if (pet.color != null) _buildDetailRow('Color', pet.color!),
        if (pet.eyeColor != null) _buildDetailRow('Eye Color', pet.eyeColor!),
        if (pet.dateOfBirth != null)
          _buildDetailRow(
              'Date of Birth', pet.dateOfBirth!.toLocal().toString()),
        if (pet.dateAdded != null)
          _buildDetailRow('Date Added', pet.dateAdded!.toLocal().toString()),
        if (pet.adoptionStatus != null)
          _buildDetailRow('Adoption Status', pet.adoptionStatus!),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
