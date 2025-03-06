import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String? fname;
  final String? lname;
  final String? image;
  final String? phone;
  final String? email;
  final String? password;

  const AuthEntity({
    this.id,
    this.fname,
    this.lname,
    this.image,
    this.phone,
    this.email,
    this.password,
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
