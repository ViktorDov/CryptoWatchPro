import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_colors.dart';
import '../../widgets/coin_card.dart';
import '../cubit/coins_cubit.dart';

class CoinsPage extends StatefulWidget {
  const CoinsPage({
    super.key,
  });

  @override
  State<CoinsPage> createState() => _CoinsPageState();
}

class _CoinsPageState extends State<CoinsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoinsCubit, CoinsState>(builder: (context, state) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Поиск',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.white,
                ),
                filled: true,
                fillColor: AppColors.backgroundFormFild,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onChanged: (value) =>
                  context.read<CoinsCubit>().updateSearchQuery(value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.searchListCoins.length,
              itemBuilder: (context, index) {
                final coin = state.searchListCoins[index];
                return CoinCard(
                  image: coin.image,
                  name: coin.name,
                  symbol: coin.symbol,
                  price: coin.currentPrice,
                  isFavorite: state.followingCoins.contains(coin),
                  onFavoritePress: () {
                    setState(() {
                      context.read<CoinsCubit>().toggleFavorite(coin);
                    });
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
