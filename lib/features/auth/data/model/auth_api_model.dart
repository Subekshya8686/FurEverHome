import 'package:equatable/equatable.dart';
import 'package:furever_home/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String? phone;
  final String email;
  final String? password;

  const AuthApiModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.image,
    required this.email,
    required this.password,
    required this.phone,
  });

  // auto generates the json values (From Json)
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() {
    return _$AuthApiModelToJson(this)..['name'] = '$fname $lname';
  }

  // to entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      fname: fname,
      lname: lname,
      image: image,
      phone: phone,
      email: email,
      password: password ?? '',
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fname: entity.fname,
      lname: entity.lname,
      image: entity.image,
      phone: entity.phone,
      email: entity.email,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [
        fname,
        lname,
        image,
        phone,
        email,
        password,
      ];
}
