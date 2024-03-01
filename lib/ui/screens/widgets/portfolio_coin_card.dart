import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class PortfolioCoinCard extends StatelessWidget {
  final String symbol;
  final String name;
  final double currentPrice;
  final double buyPrice;
  final String image;

  const PortfolioCoinCard({
    super.key,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.buyPrice,
    required this.image,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${buyPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (currentPrice > buyPrice)
                Text(
                  '+${(currentPrice - buyPrice).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                )
              else
                Text(
                  '${(currentPrice - buyPrice).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
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
