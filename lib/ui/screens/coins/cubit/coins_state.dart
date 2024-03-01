part of 'coins_cubit.dart';

enum CoinsStatus { initial, loading, loaded, error }

class CoinsState extends Equatable {
  final CoinsStatus status;
  final List<Coin> coins;
  final List<Coin> followingCoins;
  final List<Coin> searchListCoins;
  final String searchWord;
  final String message;
  final bool isFavorite;
  const CoinsState({
    this.status = CoinsStatus.initial,
    this.coins = const <Coin>[],
    this.followingCoins = const <Coin>[],
    this.searchListCoins = const <Coin>[],
    this.searchWord = '',
    this.message = '',
    this.isFavorite = false,
  });

  @override
  List<Object> get props => [
        status,
        coins,
        followingCoins,
        searchListCoins,
        searchWord,
        message,
        isFavorite
      ];

  CoinsState copyWith({
    CoinsStatus? status,
    List<Coin>? coins,
    List<Coin>? followingCoins,
    List<Coin>? serchListCoins,
    String? currency,
    String? searchWord,
    bool? isFavorite,
    String? message,
  }) {
    return CoinsState(
      status: status ?? this.status,
      coins: coins ?? this.coins,
      followingCoins: followingCoins ?? this.followingCoins,
      searchListCoins: serchListCoins ?? searchListCoins,

      searchWord: searchWord ?? this.searchWord,
      isFavorite: isFavorite ?? this.isFavorite,
      message: message ?? this.message,
    );
  }
}
