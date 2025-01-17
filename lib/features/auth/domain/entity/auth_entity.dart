import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String fname;
  final String lname;
  final String? image;

  // final String dateOfBirth;
  // final String email;
  final String username;
  final String password;

  const AuthEntity({
    this.id,
    required this.fname,
    required this.lname,
    this.image,
    // required this.dateOfBirth,
    // required this.email,
    required this.username,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        fname,
        lname,
        // dateOfBirth,
        // email,
        image,
        username,
        password,
      ];
}
