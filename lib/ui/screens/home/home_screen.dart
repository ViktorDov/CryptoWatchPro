import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_colors.dart';
import '../coins/coins_screen.dart';
import '../coins/cubit/coins_cubit.dart';
import '../portfolio/portfolio_screen.dart';
import '../profile/profile_screen.dart';
import '../widgets/custom_navbar.dart';

class HomeScreen extends StatefulWidget {
  static const path = '/';
  static const name = 'homeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      currentIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinsCubit, CoinsState>(
      builder: (context, state) {
        switch (state.status) {
          case CoinsStatus.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case CoinsStatus.loaded:
            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              body: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  CoinsScreen(),
                  PortfolioScreen(),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: CustomNavBar(
                selectedIndex: currentIndex,
                onItemTapped: onItemTapped,
              ),
            );
          case CoinsStatus.error:
            return Center(
              child: Text(state.message),
            );
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
