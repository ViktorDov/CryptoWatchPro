import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final void Function(int) onItemTapped;
  final int selectedIndex;
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          selectedIndex == 0
              ? 'assets/icons/coin_chosen.svg'
              : 'assets/icons/coin.svg',
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          selectedIndex == 1
              ? 'assets/icons/portfolio_chosen.svg'
              : 'assets/icons/portfolio.svg',
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          selectedIndex == 2
              ? 'assets/icons/profile_chosen.svg'
              : 'assets/icons/profile.svg',
        ),
        label: '',
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Color.fromARGB(154, 0, 85, 255), spreadRadius: 4, blurRadius: 15),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: items,
            onTap: onItemTapped,
            currentIndex: selectedIndex,
            backgroundColor: AppColors.backgroundColor,
          ),
        ),
      ),
    );
  }
}
