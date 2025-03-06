import 'package:dio/dio.dart';
import 'package:furever_home/app/constants/api_endpoints.dart';
import 'package:furever_home/features/adoption/data/data_source/adoption_datasource.dart';
import 'package:furever_home/features/adoption/domain/entity/adoption_entity.dart';

class AdoptionRemoteDatasource implements IAdoptionDatasource {
  final Dio _dio;

  AdoptionRemoteDatasource(this._dio);

  // Create adoption application
  Future<void> createAdoption(AdoptionEntity adoption) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.createAdoption,
        // Adjust with your backend endpoint for creating adoption
        data: {
          "applicantId":
              adoption.applicantId, // Applicant ID (ObjectId as per backend)
          "petId": adoption.petId, // Pet ID (ObjectId as per backend)
          "applicantName": adoption.applicantName,
          "applicantEmail": adoption.applicantEmail,
          "applicantPhone": adoption.applicantPhone,
          "districtOrCity": adoption.districtOrCity,
          "homeAddress": adoption.homeAddress,
          "householdMembers": adoption.householdMembers,
          "hasPets": adoption.hasPets,
          "petDetails": adoption.petDetails, // Optional field
          "residenceType": adoption.residenceType,
          "reasonForAdoption": adoption.reasonForAdoption,
          "experienceWithPets": adoption.experienceWithPets,
          "agreementToTerms": adoption.agreementToTerms,
        },
      );
      print(response);
      if (response.statusCode == 201) {
        return; // Successfully created the adoption application
      } else {
        throw Exception(
            "Adoption application failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("An error occurred: ${e.toString()}");
    }
  }
}
