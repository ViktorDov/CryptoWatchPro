import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import 'pages/coins_page.dart';
import 'pages/following_page.dart';

class CoinsScreen extends StatefulWidget {
  static const path = '/';
  static const name = 'Coins';
  const CoinsScreen({super.key});

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen> {
  late PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Text(
                'Рынок',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  SizedBox(
                    width: AppSize.myWidth(context) * 0.45,
                    child: ElevatedButton(
                      onPressed: () => onPageChanged(0),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.backgroundFormFild,
                        textStyle: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          side: currentIndex == 0
                              ? const BorderSide(color: Colors.white)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Монеты'),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: AppSize.myWidth(context) * 0.45,
                    child: ElevatedButton(
                      onPressed: () => onPageChanged(1),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.backgroundFormFild,
                        textStyle: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          side: currentIndex == 1
                              ? const BorderSide(color: Colors.white)
                              : BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Избранное'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: onPageChanged,
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CoinsPage(),
                    FollowingPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
