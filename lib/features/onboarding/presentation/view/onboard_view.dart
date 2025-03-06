import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furever_home/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:furever_home/features/onboarding/presentation/widget/onboarding_page_widget.dart';

class OnboardView extends StatelessWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDDEC9),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<OnboardCubit, int>(
              builder: (context, currentPage) {
                final cubit = context.read<OnboardCubit>();
                return PageView(
                  controller: cubit.pageController,
                  onPageChanged: cubit.onPageChanged,
                  children: [
                    OnboardingPage(
                      image: 'assets/images/dog7.png',
                      title: 'Welcome to FurEver Home',
                      description:
                          'Find your new furry friend and start your journey with adoption or fostering!',
                      isLastPage: false,
                      onNext: cubit.goToNextPage,
                    ),
                    OnboardingPage(
                      image: 'assets/images/dog2.png',
                      title: 'Adopt or Foster',
                      description:
                          'Browse profiles of pets available for adoption or fostering and make a difference in their lives.',
                      isLastPage: false,
                      onNext: cubit.goToNextPage,
                    ),
                    OnboardingPage(
                      image: 'assets/images/dog3.png',
                      title: 'Support a Pet in Need',
                      description:
                          'Whether it\'s a temporary foster or a forever home, you can help a pet find the care they deserve.',
                      isLastPage: true,
                      onNext: () {
                        // Check if it's the last page before navigating
                        if (currentPage == 2) {
                          cubit.navigateToLogin(context);
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          BlocBuilder<OnboardCubit, int>(
            builder: (context, currentPage) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 8,
                    width: currentPage == index ? 24 : 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Color(0xFF96614D)
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
