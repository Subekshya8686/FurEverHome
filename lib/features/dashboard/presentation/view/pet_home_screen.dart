import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';

class PetHomeScreen extends StatefulWidget {
  const PetHomeScreen({Key? key}) : super(key: key);

  @override
  _PetHomeScreenState createState() => _PetHomeScreenState();
}

class _PetHomeScreenState extends State<PetHomeScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically load pets when screen opens
    context.read<PetBloc>().add(GetAllPetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlocBuilder<PetBloc, PetState>(
              builder: (context, state) {
                if (state is PetLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PetErrorState) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is PetLoadedState) {
                  return Expanded(
                    child: screenWidth > 600 // For tablet screens, use grid
                        ? GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Two columns on tablet
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 2.5, // Adjust item aspect ratio
                            ),
                            itemCount: state.pets.length,
                            itemBuilder: (context, index) {
                              final pet = state.pets[index];
                              return PetCard(pet: pet);
                            },
                          )
                        : ListView.builder(
                            itemCount: state.pets.length,
                            itemBuilder: (context, index) {
                              final pet = state.pets[index];
                              return PetCard(pet: pet);
                            },
                          ),
                  );
                } else {
                  return const Center(child: Text('No pets available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final PetEntity pet;

  const PetCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://10.0.2.2:5000/uploads/${pet.photo}';

    return GestureDetector(
      onTap: () {
        context.read<HomeCubit>().showPetDetails(pet);
      },
      child: Card(
        margin: const EdgeInsets.all(14.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                      onError: (error, stackTrace) {},
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              pet.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${pet.age} years old',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pet.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
