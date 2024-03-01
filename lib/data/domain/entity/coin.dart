import 'dart:convert';

class Coin {
  final String symbol;
  final String name;
  final double currentPrice;
  final String image;
  Coin({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.image,
  });

  Coin copyWith({
    String? symbol,
    String? name,
    double? currentPrice,
    String? image,
  }) {
    return Coin(
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
      currentPrice: currentPrice ?? this.currentPrice,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symbol': symbol,
      'name': name,
      'current_price': currentPrice,
      'image': image,
    };
  }

  factory Coin.fromMap(Map<String, dynamic> map) {
    return Coin(
      symbol: map['symbol'] as String,
      name: map['name'] as String,
      currentPrice: map['current_price'] is int
        ? (map['current_price'] as int).toDouble()
        : map['current_price'] as double,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coin.fromJson(String source) =>
      Coin.fromMap(json.decode(source) as Map<String, dynamic>);
}
