import 'package:equatable/equatable.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String? fname;
  final String? lname;
  final String? image;
  final String? phone;
  final String? email;
  final String? password;

  const AuthApiModel({
    this.id,
    this.fname,
    this.lname,
    this.image,
    this.phone,
    this.email,
    this.password,
  });

  // auto generates the json values (From Json)
  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    // Check if the 'name' field exists and split it into fname and lname
    String fullName = json['name'] ?? "";
    List<String> nameParts = fullName.split(" ");

    return _$AuthApiModelFromJson(json).copyWith(
      fname: nameParts.isNotEmpty ? nameParts[0] : null,
      // First part of the name
      lname: nameParts.length > 1
          ? nameParts[1]
          : null, // Second part of the name (if exists)
    );
  }

  Map<String, dynamic> toJson() {
    return _$AuthApiModelToJson(this)
      ..['name'] = '$fname $lname'; // Convert fname and lname to 'name' in JSON
  }

  // to entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id ?? "",
      // Fallback to empty string if id is null
      fname: fname ?? "",
      // Fallback to empty string if fname is null
      lname: lname ?? "",
      // Fallback to empty string if lname is null
      image: image ?? "",
      // Fallback to empty string if image is null
      phone: phone ?? "",
      // Fallback to empty string if phone is null
      email: email ?? "",
      // Fallback to empty string if email is null
      password: password ?? "", // Fallback to empty string if password is null
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.id,
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
    );
  }

  // Adding a copyWith method for immutable model updates
  AuthApiModel copyWith({
    String? id,
    String? fname,
    String? lname,
    String? image,
    String? phone,
    String? email,
    String? password,
  }) {
    return AuthApiModel(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fname,
        lname,
        image,
        phone,
        email,
        password,
      ];
}
