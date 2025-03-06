import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/dashboard/domain/entity/pet_entity.dart';
import 'package:furever_home/features/foster/presentation/view_model/foster_bloc.dart';
import 'package:furever_home/features/home/presentation/view_model/home_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FosterFormPage extends StatefulWidget {
  final PetEntity pet;

  FosterFormPage({required this.pet});

  @override
  State<FosterFormPage> createState() => _FosterFormPageState();
}

class _FosterFormPageState extends State<FosterFormPage> {
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
  final TextEditingController _reasonForFosteringController =
      TextEditingController();
  final TextEditingController _experienceWithPetsController =
      TextEditingController();
  final TextEditingController _availabilityDurationController =
      TextEditingController();

  bool agreementToTerms = true;

  Future<String?> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID');
  }

  void goBackToPetList() {
    context.read<HomeCubit>().goBackToPetList();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'http://10.0.2.2:5000/uploads/${widget.pet.photo}';
    // String imageUrl = 'http://192.168.1.5:5000/uploads/${widget.pet.photo}';

    final String applicantId = '';
    final String petId = widget.pet.id; // Use the actual pet ID passed in

    return Scaffold(
      appBar: AppBar(
        title: const Text('Foster Form'),
        backgroundColor: Colors.grey[200],
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            goBackToPetList();
          },
        ),
      ),
      body: BlocConsumer<FosterFormBloc, FosterFormState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Foster form submitted successfully!')),
            );
            goBackToPetList(); // Go back to pet list after success
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(imageUrl),
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
                      controller: _reasonForFosteringController,
                      decoration:
                          InputDecoration(labelText: 'Reason for Fostering'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _experienceWithPetsController,
                      decoration:
                          InputDecoration(labelText: 'Experience with Pets'),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _availabilityDurationController,
                      decoration: InputDecoration(
                          labelText:
                              'Availability Duration (short-term/long-term)'),
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
                    state.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<FosterFormBloc>().add(
                                      SubmitFormEvent(
                                        applicantId: applicantId,
                                        petId: petId,
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
                                        hasPets: true,
                                        petDetails: _petDetailsController
                                                .text.isNotEmpty
                                            ? _petDetailsController.text
                                            : null,
                                        residenceType:
                                            _residenceTypeController.text,
                                        reasonForFostering:
                                            _reasonForFosteringController.text,
                                        experienceWithPets:
                                            _experienceWithPetsController.text,
                                        availabilityDuration:
                                            _availabilityDurationController
                                                .text,
                                        abilityToHandleMedicalNeeds: true,
                                        hasFencedYard: false,
                                        agreementToTerms: agreementToTerms,
                                      ),
                                    );
                              }
                            },
                            child: Text('Submit Form'),
                          ),
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
