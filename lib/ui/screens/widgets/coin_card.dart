import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';

class CoinCard extends StatelessWidget {
  final String image;
  final String name;
  final String symbol;
  final double price;
  final bool isFavorite;
  final VoidCallback onFavoritePress;
  const CoinCard({
    super.key,
    required this.image,
    required this.name,
    required this.symbol,
    required this.price,
    required this.isFavorite,
    required this.onFavoritePress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Image.network(image),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.cutString(12),
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                symbol.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              overflow: TextOverflow.clip,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: onFavoritePress,
            icon: isFavorite
                ? SvgPicture.asset('assets/icons/heart.svg')
                : SvgPicture.asset('assets/icons/heart_outlined.svg'),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String cutString(int len) {
    if (length > len) {
      return '${substring(0, len - 3)}..';
    }
    return this;
  }
}
