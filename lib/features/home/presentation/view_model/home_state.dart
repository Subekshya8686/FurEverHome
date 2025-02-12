import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/app/di/di.dart';
import 'package:furever_home/features/dashboard/presentation/view/pet_home_screen.dart';
import 'package:furever_home/features/dashboard/presentation/view_model/pet_bloc.dart';
import 'package:furever_home/features/profile/presentation/view/profile_view.dart';
import 'package:furever_home/features/search/presentation/view/search_page.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<PetBloc>(),
          child: const PetHomeScreen(),
        ),
        BlocProvider(
          create: (context) => getIt<PetBloc>(),
          child: SearchPage(),
        ),
        // BlocProvider(
        //   create: (context) => getIt<FosterFormBloc>(),
        //   child: FosterFormPage(),
        // ),
        const ProfileView(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
