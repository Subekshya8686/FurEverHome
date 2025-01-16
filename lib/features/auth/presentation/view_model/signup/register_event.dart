part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterStudent extends RegisterEvent {
  final BuildContext context;
  final String fname;
  final String lname;
  final String? image;

  // final BatchEntity batch;
  // final List<CourseEntity> courses;
  final String username;
  final String password;

  const RegisterStudent({
    required this.context,
    required this.fname,
    required this.lname,
    // required this.batch,
    // required this.courses,
    required this.password,
    required this.username,
    this.image,
  });

  @override
  List<Object> get props => [fname, lname, username, password, context];
}

class NavigateToHomeScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToHomeScreenEvent({
    required this.context,
    required this.destination,
  });

  @override
  List<Object> get props => [context, destination];
}
