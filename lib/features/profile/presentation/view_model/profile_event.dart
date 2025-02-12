part of 'profile_bloc.dart';

abstract class UserByIdEvent extends Equatable {
  const UserByIdEvent();

  @override
  List<Object?> get props => [];
}

class GetUserByIdEvent extends UserByIdEvent {
  final String id;

  const GetUserByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateUserByIdEvent extends UserByIdEvent {
  final String id;
  final AuthEntity updatedUser;

  // final BuildContext context;

  const UpdateUserByIdEvent({
    required this.id,
    required this.updatedUser,
    // required this.context,
  });

  @override
  List<Object?> get props => [id, updatedUser];
}

class LoadImage extends UserByIdEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class NavigateToProfilePageEvent extends UserByIdEvent {
  final BuildContext context;
  final String id; // Add the id field here

  const NavigateToProfilePageEvent({
    required this.context,
    required this.id, // Make sure to pass the id in the constructor
  });

  @override
  List<Object?> get props => [context, id];
}
