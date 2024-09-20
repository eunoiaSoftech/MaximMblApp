import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/res/app_colors.dart';
import '../../../core/res/app_functions.dart';
import '../../../core/res/app_storage.dart';
import '../../../core/res/app_styles.dart';
import '../../auth/presentation/ui/login_screen.dart'; // For dots indicator

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int currentPage = 0;

  // List of onboarding pages
  List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/new/truck_glow.png',
      'heading': 'Maxim fleet management',
      'smallImage': 'assets/images/new/underline.png',
      'description': 'Helps you to track deliveries by giving on time updates'
    },
    {
      'image': 'assets/images/new/truck_scan.png',
      'heading': 'Driver management system',
      'smallImage': 'assets/images/new/underline.png',
      'description':
          'Helps drivers to book there Expense, and track there performance'
    },
    {
      'image': 'assets/images/new/truck_nav.png',
      'heading': 'Fleet management GPS',
      'smallImage': 'assets/images/new/underline.png',
      'description': 'Helps you to get live updates of your fleet'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Dots indicator
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const ExpandingDotsEffect(
                  radius: 8,
                  dotHeight: 11,
                  dotWidth: 11,
                  activeDotColor: AppColors.newBlue,
                  spacing: 8,
                  dotColor: Colors.grey),
            ),

            const SizedBox(
              height: 20,
            ),
            // Next or Get Started Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  if (currentPage == 2) {
                    AppStorage().saveOnBoarding(true);
                    Navigator.of(context)
                        .pushReplacement(goToRoute(const LoginScreen()));
                  } else {
                    // Otherwise, go to the next page
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.newBlue, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Rounded corners
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentPage == 0 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return buildOnboardingPage(
                    image: onboardingData[index]['image']!,
                    heading: onboardingData[index]['heading']!,
                    smallImage: onboardingData[index]['smallImage']!,
                    description: onboardingData[index]['description']!,
                    index: index);
              },
            ),
          ),
          // Dots and "Next" button
        ],
      ),
    );
  }

  // Widget to build each onboarding page
  Widget buildOnboardingPage({
    required String image,
    required String heading,
    required String smallImage,
    required String description,
    required int index,
  }) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .55,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),

        // Heading
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                heading,
                textAlign: TextAlign.center,
                style: AppStyles.titleTextStyle(context).copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: appSize(context) / 40,
                ),
              ),

              // Small image
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: index == 1
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
                children: [
                  index == 2
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Image.asset(
                            smallImage,
                            width: 80,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: Image.asset(
                            smallImage,
                            width: 80,
                          ),
                        ),
                ],
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: AppStyles.titleTextStyle(context).copyWith(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
