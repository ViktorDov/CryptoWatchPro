import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/api/api_client.dart';
import '../../../../data/domain/entity/coin.dart';
import '../../../../data/domain/entity/portfolio.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final _api = ApiClient();
  PortfolioCubit() : super(const PortfolioState()) {
    init();
  }

  Future<void> init() async {
    await _getCoins();
    getPortfolioCoins();
    await _getTotalPortfolioBalance();
    if (state.portfolioCoins.isEmpty) {
      log('epty');
      emit(state.copyWith(status: PortfolioStatus.isEmpty));
    } else {
      log('not epty');
      emit(state.copyWith(status: PortfolioStatus.isNotEmpty));
    }
  }

  Future<void> _getCoins() async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    try {
      final coins = await _api.getCoins();

      emit(state.copyWith(coins: coins));
    } catch (e) {
      emit(
        state.copyWith(errorMessage: 'Error fetching coins'),
      );
    }
  }

  Future<void> _saveTotalPortfolioBalance(double price) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalPortfolioBalance', state.totalPortfolioBalance);
  }

  Future<void> _getTotalPortfolioBalance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final totalPortfolioBalance = prefs.getDouble('totalPortfolioBalance') ?? 0;
    emit(state.copyWith(totalPortfolioBalance: totalPortfolioBalance));
  }

  void getPortfolioCoins() async {
    final List<Portfolio> portfolio = [];
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _getTotalPortfolioBalance();
    final List<String> savedCoins = prefs.getStringList('portfolioCoins') ?? [];
    final coinsForPortfolio = state.coins
        .where((element) => savedCoins.contains(element.symbol))
        .toList();
    if (coinsForPortfolio.isNotEmpty) {
      final newProfileCoins = coinsForPortfolio.map((coin) {
        final double buyPrice = prefs.getDouble('${coin.symbol}_buyPrice') ?? 0;
        final coinNetWorth = (coin.currentPrice - buyPrice) + state.totalPortfolioBalance;
        emit(state.copyWith(totalPortfolioBalance: coinNetWorth)); 
        return Portfolio(
          symbol: coin.symbol,
          name: coin.name,
          currentPrice: coin.currentPrice,
          buyPrice: buyPrice,
          image: coin.image,
        );
      
      }).toList();
      portfolio.addAll(newProfileCoins);
      emit(state.copyWith(
          portfolioCoins: portfolio, status: PortfolioStatus.isNotEmpty));
    } else {
      emit(state.copyWith(status: PortfolioStatus.isEmpty));
    }
  }

  void requestAddCoinName(String coinName) {
    emit(state.copyWith(addCoinName: coinName));
  }

  void requestAddCoinAmount(String coinAmount) {
    final double amount = double.parse(coinAmount);
    emit(state.copyWith(addCoinAmount: amount));
  }

  void requestAddCoinBuyPrice(String coinPrice) {
    if (coinPrice.isNotEmpty) {
      final double price = double.parse(coinPrice);
      emit(state.copyWith(addCoinBuyPrice: price));
    } 
  }

  void addCoinToPortfolio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final coinToAdd =
        state.coins.firstWhere((coin) => coin.name == state.addCoinName);
    final newCoin = Portfolio(
      symbol: coinToAdd.symbol,
      name: coinToAdd.name,
      currentPrice: coinToAdd.currentPrice,
      buyPrice: state.addCoinBuyPrice,
      image: coinToAdd.image,
    );
    final updatedCoins = List<Portfolio>.from(state.portfolioCoins)
      ..add(newCoin);

    
    final coinNetWorth = coinToAdd.currentPrice - state.addCoinBuyPrice;
    final total = state.totalPortfolioBalance + coinNetWorth;
    _saveTotalPortfolioBalance(total);

    await prefs.setStringList(
        'portfolioCoins', updatedCoins.map((e) => e.symbol).toList());
    await prefs.setDouble(
        '${coinToAdd.symbol}_buyPrice', state.addCoinBuyPrice);
    getPortfolioCoins(); 
    emit(state.copyWith(status: PortfolioStatus.isNotEmpty, totalPortfolioBalance: total)); 
  }
}


/*
void addCoinToPortfolio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final coinToAdd =
        state.coins.firstWhere((coin) => coin.name == state.addCoinName);
    final newCoin = Portfolio(
      symbol: coinToAdd.symbol,
      name: coinToAdd.name,
      currentPrice: coinToAdd.currentPrice,
      buyPrice: state.addCoinBuyPrice,
      image: coinToAdd.image,
    );
    final updatedCoins = List<Portfolio>.from(state.portfolioCoins)
      ..add(newCoin);

    final coinNetWorth = coinToAdd.currentPrice - state.addCoinBuyPrice;
    final total = state.totalPortfolioBalance + coinNetWorth;
    _saveTotalPortfolioBalance(total);

    await prefs.setStringList(
        'portfolioCoins', updatedCoins.map((e) => e.symbol).toList());
    await prefs.setDouble(
        '${coinToAdd.symbol}_buyPrice', state.addCoinBuyPrice);
    emit(state.copyWith(
        portfolioCoins: updatedCoins,
        status: PortfolioStatus.isNotEmpty,
        totalPortfolioBalance: total));
    log('portfolioCoins: $updatedCoins');
  }
*/