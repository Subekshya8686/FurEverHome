import 'package:flutter/material.dart';
import 'package:furever_home/view/login_view.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Function to go to the next page
  void _goToNextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                  image: 'assets/images/dog1.png', // Replace with your image asset
                  title: 'Welcome to FurEver Home',
                  description: 'Find your new furry friend and start your journey with adoption or fostering!',
                  isLastPage: false, // Not the last page
                  onNext: _goToNextPage, // Add the onNext callback
                ),
                OnboardingPage(
                  image: 'assets/images/dog2.png',
                  title: 'Adopt or Foster',
                  description: 'Browse profiles of pets available for adoption or fostering and make a difference in their lives.',
                  isLastPage: false, // Not the last page
                  onNext: _goToNextPage, // Add the onNext callback
                ),
                OnboardingPage(
                  image:'assets/images/dog3.png',
                  title: 'Support a Pet in Need',
                  description: 'Whether it\'s a temporary foster or a forever home, you can help a pet find the care they deserve.',
                  isLastPage: true, // The last page
                  onNext: () {
                    // Navigate to the LoginView when "Get Started" is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginView()),
                    );
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback onNext;

  const OnboardingPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300), // Display the image
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          if (!isLastPage) // Display "Next" button on non-last pages
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          if (isLastPage) // Display "Get Started" button on the last page
            ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
