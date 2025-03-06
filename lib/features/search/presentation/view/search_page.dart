import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/dashboard/presentation/view/pet_home_screen.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SearchPage extends StatefulWidget {
  @override
  _PetSearchScreenState createState() => _PetSearchScreenState();
}

class _PetSearchScreenState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PetBloc>().add(GetAllPetsEvent());

    // Listen for shake gesture
    accelerometerEventStream().listen((event) {
      if (_isShakeDetected(event)) {
        _clearSearch();
      }
    });
  }

  bool _isShakeDetected(AccelerometerEvent event) {
    const double shakeThreshold = 10.0;
    return event.x.abs() > shakeThreshold ||
        event.y.abs() > shakeThreshold ||
        event.z.abs() > shakeThreshold;
  }

  void _clearSearch() {
    _searchController.clear();
    context.read<PetBloc>().add(SearchPetsEvent(''));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? screenWidth * 0.08 : 16.0,
          vertical: isTablet ? 20.0 : 8.0,
        ),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<PetBloc>().add(SearchPetsEvent(query));
              },
              style: TextStyle(fontSize: isTablet ? 20 : 16),
              decoration: InputDecoration(
                labelText: "Search for a pet",
                labelStyle: TextStyle(fontSize: isTablet ? 18 : 14),
                prefixIcon: Icon(Icons.search, size: isTablet ? 30 : 24),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 16.0 : 8.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: isTablet ? 18.0 : 12.0,
                  horizontal: isTablet ? 20.0 : 12.0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is PetErrorState) {
                    return Center(
                        child: Text(
                      "Error: ${state.message}",
                      style: TextStyle(fontSize: isTablet ? 18 : 14),
                    ));
                  } else if (state is PetLoadedState) {
                    return _buildPetList(state.pets, isTablet);
                  }
                  return Center(
                      child: Text(
                    "Start searching for pets!",
                    style: TextStyle(fontSize: isTablet ? 18 : 14),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPetList(List<PetEntity> pets, bool isTablet) {
    if (pets.isEmpty) {
      return Center(
          child: Text(
        "No pets found.",
        style: TextStyle(fontSize: isTablet ? 18 : 14),
      ));
    }
    return isTablet
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Two columns for tablets
              childAspectRatio: 2.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              return PetCard(pet: pets[index]);
            },
          )
        : ListView.builder(
            itemCount: pets.length,
            itemBuilder: (context, index) {
              return PetCard(pet: pets[index]);
            },
          );
  }
}
