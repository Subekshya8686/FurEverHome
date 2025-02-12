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
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PetBloc>().add(GetAllPetsEvent()); // Load pets on screen load

    // Listen for shake gesture using accelerometerEventStream
    accelerometerEventStream().listen((AccelerometerEvent event) {
      if (_isShakeDetected(event)) {
        _clearSearch();
      }
    });
  }

  bool _isShakeDetected(AccelerometerEvent event) {
    // You can adjust the threshold value based on how sensitive you want the shake detection to be
    const double shakeThreshold = 10.0;

    // Check if the acceleration exceeds the threshold, indicating a shake
    return event.x.abs() > shakeThreshold ||
        event.y.abs() > shakeThreshold ||
        event.z.abs() > shakeThreshold;
  }

  void _clearSearch() {
    _searchController.clear();
    context
        .read<PetBloc>()
        .add(SearchPetsEvent('')); // Clear search query in the PetBloc
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                context.read<PetBloc>().add(SearchPetsEvent(query));
              },
              decoration: InputDecoration(
                labelText: "Search for a pet ",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<PetBloc, PetState>(
              builder: (context, state) {
                if (state is PetLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PetErrorState) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is PetLoadedState) {
                  return _buildPetList(state.pets);
                }
                return Center(child: Text("Start searching for pets!"));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetList(List<PetEntity> pets) {
    if (pets.isEmpty) {
      return Center(child: Text("No pets found."));
    }
    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        return PetCard(pet: pets[index]); // ✅ Using PetCard instead of ListTile
      },
    );
  }
}
