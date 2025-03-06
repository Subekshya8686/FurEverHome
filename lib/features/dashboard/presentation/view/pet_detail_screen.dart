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
    const double shakeThreshold = 10.0;
    return event.x.abs() > shakeThreshold ||
        event.y.abs() > shakeThreshold ||
        event.z.abs() > shakeThreshold;
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://10.0.2.2:5000/uploads/${widget.pet.photo}';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            goBackToPetList();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isTablet = constraints.maxWidth >= 600;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      imageUrl,
                      width: isTablet ? 300 : 200,
                      height: isTablet ? 300 : 200,
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
                  style: TextStyle(
                    fontSize: isTablet ? 26 : 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.pet.age} years old',
                  style: TextStyle(
                      fontSize: isTablet ? 22 : 18, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.pet.description,
                  style: TextStyle(fontSize: isTablet ? 22 : 16),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().petFosterScreen(widget.pet);
                      },
                      child: const Text('Foster'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: isTablet ? 50.0 : 40.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeCubit>().petAdoptionScreen(widget.pet);
                      },
                      child: const Text('Adopt'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 14.0, horizontal: isTablet ? 50.0 : 40.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Pet Details",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: isTablet ? 20 : 16),
                ),
                const SizedBox(height: 16),
                PetDetailFields(pet: widget.pet),
              ],
            );
          },
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
    bool isTablet = MediaQuery.of(context).size.width >= 600;

    return Column(
      children: [
        if (pet.type != null) _buildDetailRow('Type', pet.type!, isTablet),
        if (pet.breed != null) _buildDetailRow('Breed', pet.breed, isTablet),
        if (pet.weight != null)
          _buildDetailRow('Weight', '${pet.weight} kg', isTablet),
        if (pet.vaccinated != null)
          _buildDetailRow(
              'Vaccinated', pet.vaccinated ? 'Yes' : 'No', isTablet),
        if (pet.specialNeeds != null)
          _buildDetailRow(
              'Special Needs', pet.specialNeeds ? 'Yes' : 'No', isTablet),
        if (pet.healthDetails != null)
          _buildDetailRow('Health Details', pet.healthDetails!, isTablet),
        if (pet.height != null)
          _buildDetailRow('Height', '${pet.height} cm', isTablet),
        if (pet.furType != null)
          _buildDetailRow('Fur Type', pet.furType!, isTablet),
        if (pet.color != null) _buildDetailRow('Color', pet.color!, isTablet),
        if (pet.eyeColor != null)
          _buildDetailRow('Eye Color', pet.eyeColor!, isTablet),
        if (pet.dateOfBirth != null)
          _buildDetailRow(
              'Date of Birth', pet.dateOfBirth!.toLocal().toString(), isTablet),
        if (pet.dateAdded != null)
          _buildDetailRow(
              'Date Added', pet.dateAdded!.toLocal().toString(), isTablet),
        if (pet.adoptionStatus != null)
          _buildDetailRow('Adoption Status', pet.adoptionStatus!, isTablet),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, bool isTablet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              '$label: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 18 : 15, // Increased for tablets
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isTablet ? 18 : 15, // Increased for tablets
              ),
            ),
          ),
        ],
      ),
    );
  }
}
