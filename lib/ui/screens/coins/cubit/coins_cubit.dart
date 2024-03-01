import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api/api_client.dart';
import '../../../../data/domain/entity/coin.dart';

part 'coins_state.dart';

class CoinsCubit extends Cubit<CoinsState> {
  final _api = ApiClient();
  CoinsCubit() : super(const CoinsState()) {
    _init();
  }

  void _init() {
    emit(state.copyWith(status: CoinsStatus.loading));
    getCoins();
  }

  Future<void> getCoins() async {
    emit(state.copyWith(status: CoinsStatus.loading));
    try {
      final coins = await _api.getCoins();
      emit(state.copyWith(status: CoinsStatus.loaded, coins: coins));
      _getFollowingCoins();
      searchCoins();
    } catch (e) {
      emit(
        state.copyWith(
          status: CoinsStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> toggleFavorite(Coin coin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final bool isFavorite = state.followingCoins.contains(coin);
    if (isFavorite) {
      final List<Coin> updatedFavorites = List.from(state.followingCoins)
        ..remove(coin);
      await prefs.setStringList(
          'followingCoins', updatedFavorites.map((e) => e.symbol).toList());
      emit(state.copyWith(followingCoins: updatedFavorites));
    } else {
      final List<Coin> updatedFavorites = List.from(state.followingCoins)
        ..add(coin);

      await prefs.setStringList(
          'followingCoins', updatedFavorites.map((e) => e.symbol).toList());
      emit(state.copyWith(followingCoins: updatedFavorites));
    }
  }

  void _getFollowingCoins() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> followingCoins =
        prefs.getStringList('followingCoins') ?? [];
    final List<Coin> coins = state.coins
        .where((coin) => followingCoins.contains(coin.symbol))
        .toList();
    emit(state.copyWith(followingCoins: coins));
  }

  void searchCoins() {
    if (state.searchWord.isEmpty) {
      emit(state.copyWith(serchListCoins: state.coins));
      return;
    } else {
      final List<Coin> searchResults = state.coins
          .where((coin) =>
              coin.name
                  .toLowerCase()
                  .contains(state.searchWord.toLowerCase()) ||
              coin.symbol
                  .toLowerCase()
                  .contains(state.searchWord.toLowerCase()))
          .toList();
      emit(state.copyWith(serchListCoins: searchResults));
    }
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchWord: query));
    searchCoins();
  }

  void updateCurrency(String currency) {
    emit(state.copyWith(currency: currency));
  }
}
