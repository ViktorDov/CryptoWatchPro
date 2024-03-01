part of 'portfolio_cubit.dart';

enum PortfolioStatus { loading, isEmpty, isNotEmpty }

class PortfolioState extends Equatable {
  final List<Coin> coins;
  final List<Portfolio> portfolioCoins;
  final String addCoinName;
  final double addCoinAmount;
  final double addCoinBuyPrice;
  final double totalPortfolioBalance;
  final PortfolioStatus status;
  final int coinNetWorth;
  final String errorMessage;

  const PortfolioState({
    this.coins = const <Coin>[],
    this.portfolioCoins = const <Portfolio>[],
    this.addCoinAmount = 0,
    this.addCoinName = '',
    this.addCoinBuyPrice = 0,
    this.totalPortfolioBalance = 0,
    this.errorMessage = '',
    this.status = PortfolioStatus.isEmpty,
    this.coinNetWorth = 0,
  });

  @override
  List<Object> get props => [
        coins,
        status,
        totalPortfolioBalance,
        portfolioCoins,
        addCoinName,
        coinNetWorth,
        addCoinAmount,
        addCoinBuyPrice,
      ];
  

  PortfolioState copyWith({
    List<Coin>? coins,
    PortfolioStatus? status,
    double? totalPortfolioBalance,
    String? addCoinName,
    double? addCoinAmount,
    double? addCoinBuyPrice,
    List<Portfolio>? portfolioCoins,
    String? errorMessage,
    int? coinNetWorth,
  }) {
    return PortfolioState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      addCoinName: addCoinName ?? this.addCoinName,
      addCoinAmount: addCoinAmount ?? this.addCoinAmount,
      addCoinBuyPrice: addCoinBuyPrice ?? this.addCoinBuyPrice,
      totalPortfolioBalance:
          totalPortfolioBalance ?? this.totalPortfolioBalance,
      portfolioCoins: portfolioCoins ?? this.portfolioCoins,
      coinNetWorth: coinNetWorth ?? this.coinNetWorth,
    );
  }
}
