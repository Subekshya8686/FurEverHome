import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/adoption/presentation/view_model/adoption_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdoptionFormPage extends StatefulWidget {
  final PetEntity pet;

  AdoptionFormPage({required this.pet});

  @override
  _AdoptionFormPageState createState() => _AdoptionFormPageState();
}

class _AdoptionFormPageState extends State<AdoptionFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _applicantNameController =
      TextEditingController();
  final TextEditingController _applicantEmailController =
      TextEditingController();
  final TextEditingController _applicantPhoneController =
      TextEditingController();
  final TextEditingController _districtOrCityController =
      TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _householdMembersController =
      TextEditingController();
  final TextEditingController _petDetailsController = TextEditingController();
  final TextEditingController _residenceTypeController =
      TextEditingController();
  final TextEditingController _reasonForAdoptionController =
      TextEditingController();
  final TextEditingController _experienceWithPetsController =
      TextEditingController();
  bool hasPets = false;
  bool agreementToTerms = false;

  Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://10.0.2.2:5000/uploads/${widget.pet.photo}';
    print(widget.pet.id);

    // String imageUrl = 'http://192.168.1.5:5000/uploads/${widget.pet.photo}';
    void goBackToPetList() {
      context.read<HomeCubit>().goBackToPetList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adoption Form'),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: goBackToPetList,
        ),
      ),
      body: BlocConsumer<AdoptionBloc, AdoptionState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Adoption form submitted successfully!')),
            );
          } else if (!state.isLoading && !state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to submit form')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display Pet Information
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              imageUrl), // Assuming `pet.imageUrl` holds the pet's image URL
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pet Name: ${widget.pet.name}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Breed: ${widget.pet.breed}'),
                            Text('Age: ${widget.pet.age} years'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _applicantNameController,
                      decoration: InputDecoration(labelText: 'Applicant Name'),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your name'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _applicantEmailController,
                      decoration: InputDecoration(labelText: 'Applicant Email'),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your email'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _applicantPhoneController,
                      decoration: InputDecoration(labelText: 'Applicant Phone'),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter your phone number'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _districtOrCityController,
                      decoration: InputDecoration(labelText: 'District/City'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _homeAddressController,
                      decoration: InputDecoration(labelText: 'Home Address'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _householdMembersController,
                      decoration:
                          InputDecoration(labelText: 'Household Members'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please enter number of household members'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Do you currently have pets?'),
                      value: hasPets,
                      onChanged: (value) {
                        setState(() {
                          hasPets = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _petDetailsController,
                      decoration: InputDecoration(labelText: 'Pet Details'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _residenceTypeController,
                      decoration: InputDecoration(labelText: 'Residence Type'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _reasonForAdoptionController,
                      decoration:
                          InputDecoration(labelText: 'Reason for Adoption'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _experienceWithPetsController,
                      decoration:
                          InputDecoration(labelText: 'Experience with Pets'),
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Do you agree to the adoption terms?'),
                      value: agreementToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreementToTerms = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocListener<AdoptionBloc, AdoptionState>(
                      listener: (context, state) {
                        if (state.isSuccess) {
                          // If the adoption is successful, go back to the pet list
                          goBackToPetList();
                        }
                      },
                      child: state.isLoading
                          ? Center(
                              child:
                                  CircularProgressIndicator()) // Show loading indicator
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  // Fetch the user ID from SharedPreferences
                                  context.read<AdoptionBloc>().add(
                                        CreateAdoptionEvent(
                                          applicantName:
                                              _applicantNameController.text,
                                          applicantEmail:
                                              _applicantEmailController.text,
                                          applicantPhone:
                                              _applicantPhoneController.text,
                                          districtOrCity:
                                              _districtOrCityController.text,
                                          homeAddress:
                                              _homeAddressController.text,
                                          householdMembers: int.parse(
                                              _householdMembersController.text),
                                          petDetails:
                                              _petDetailsController.text,
                                          residenceType:
                                              _residenceTypeController.text,
                                          reasonForAdoption:
                                              _reasonForAdoptionController.text,
                                          experienceWithPets:
                                              _experienceWithPetsController
                                                  .text,
                                          petId: widget.pet.id,
                                          hasPets: hasPets,
                                          agreementToTerms: agreementToTerms,
                                          applicantId:
                                              '', // Use the userId here if available
                                        ),
                                      );
                                }
                              },
                              child: Text('Submit Form'),
                            ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
