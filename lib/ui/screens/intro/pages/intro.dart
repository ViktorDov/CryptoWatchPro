
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';

class IntroPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int currentPage;
  final String buttonTitle;
  final PageController pageController;

  const IntroPage({
    Key? key,
    required this.image,
    required this.title,
    required this.buttonTitle,
    required this.description,
    required this.pageController,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          const BackgroundRectangle(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(image),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundRectangle extends StatelessWidget {
  const BackgroundRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: -40,
          child: Image.asset('assets/images/rect.png'),
        ),
        Positioned(
          top: 90,
          right: -30,
          child: Image.asset('assets/images/rect.png'),
        ),
        Positioned(
          bottom: 320,
          left: -30,
          child: Image.asset('assets/images/rect.png'),
        ),
        Positioned(
          bottom: 340,
          right: 30,
          child: Image.asset('assets/images/rect.png'),
        ),
        Positioned(
          bottom: 80,
          left: -5,
          child: Image.asset('assets/images/rect.png'),
        ),
        Positioned(
          bottom: 170,
          right: -30,
          child: Image.asset('assets/images/rect.png'),
        ),
      ],
    );
  }
}
