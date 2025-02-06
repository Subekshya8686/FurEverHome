import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;
  final String email;
  final String password;
  final String? phone;

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    this.phone,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        fname,
        lname,
        email,
        image,
        phone,
        password,
      ];
}
