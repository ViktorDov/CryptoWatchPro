import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/app_colors.dart';
import '../../widgets/coin_card.dart';
import '../cubit/coins_cubit.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: BlocBuilder<CoinsCubit, CoinsState>(
        builder: (context, state) {
          return state.followingCoins.isEmpty
              ? const Center(
                  child: Text(
                    'У вас пока нет избранных монет(',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: state.followingCoins.length,
                  itemBuilder: (context, index) {
                    final coin = state.followingCoins[index];
                    return CoinCard(
                      image: coin.image,
                      name: coin.name,
                      symbol: coin.symbol,
                      price: coin.currentPrice,
                      isFavorite: state.followingCoins.contains(coin),
                      onFavoritePress: () {
                        context.read<CoinsCubit>().toggleFavorite(coin);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
