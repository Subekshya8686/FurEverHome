import 'package:dio/dio.dart';
import 'package:furever_home/app/constants/api_endpoints.dart';
import 'package:furever_home/features/foster/data/data_source/foster_datasource.dart';
import 'package:furever_home/features/foster/domain/entity/foster_entity.dart';

class FosterRemoteDatasource implements IFosterDataSource {
  final Dio _dio;

  FosterRemoteDatasource(this._dio);

  @override
  Future<void> submitFosterApplication(
      FosterApplicationEntity fosterApplication) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.createFosterApplication,
        // Adjust with your backend endpoint
        data: {
          "applicantId": fosterApplication.applicantId,
          "petId": fosterApplication.petId,
          "applicantName": fosterApplication.applicantName,
          "applicantEmail": fosterApplication.applicantEmail,
          "applicantPhone": fosterApplication.applicantPhone,
          "districtOrCity": fosterApplication.districtOrCity,
          "homeAddress": fosterApplication.homeAddress,
          "householdMembers": fosterApplication.householdMembers,
          "hasPets": fosterApplication.hasPets,
          "petDetails": fosterApplication.petDetails, // Optional field
          "residenceType": fosterApplication.residenceType,
          "reasonForFostering": fosterApplication.reasonForFostering,
          "experienceWithPets": fosterApplication.experienceWithPets,
          "availabilityDuration": fosterApplication.availabilityDuration,
          "abilityToHandleMedicalNeeds":
              fosterApplication.abilityToHandleMedicalNeeds,
          "hasFencedYard": fosterApplication.hasFencedYard,
          "agreementToTerms": fosterApplication.agreementToTerms,
        },
      );

      if (response.statusCode == 201) {
        return; // Successfully created the foster application
      } else {
        throw Exception("Foster application failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
