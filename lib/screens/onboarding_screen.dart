import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_home_screen.dart'; // Import the HomeScreen

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      image: 'assets/svg/undraw_to_do_list.svg',
      title: 'Welcome to Our App',
    ),
    OnboardingItem(
      image: 'assets/svg/undraw_completing.svg',
      title: 'Explore Features',
    ),
    OnboardingItem(
      image: 'assets/svg/undraw_welcome_cats.svg',
      title: 'Get Started!',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingItems.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: onboardingItems[index].image,
                  title: onboardingItems[index].title,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(onboardingItems.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 10,
                width: _currentIndex == index ? 25 : 10, // Active dot length
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomeScreen(title: 'Tody Home Page')),
                      (Route<dynamic> route) => false);
                },
                child: const Text('Continue'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class OnboardingItem {
  final String image;
  final String title;

  OnboardingItem({required this.image, required this.title});
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;

  const OnboardingPage({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(image, semanticsLabel: title, width: 150, height: 150),
        const SizedBox(height: 70),
        Text(
          title,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
