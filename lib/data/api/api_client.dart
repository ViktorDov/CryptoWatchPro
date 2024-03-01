import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../domain/entity/coin.dart';

class ApiClient {
  static const baseUrl =
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&locale=en';
  final _dio = Dio();
  final log = Logger();

  Future<List<Coin>> getCoins() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Coin> coins = data.map((e) => Coin.fromMap(e)).toList();
        return coins;
      } else {
        throw Exception('Failed to load coins: ${response.statusCode}');
      }
    } on DioError catch (e) {
      throw Exception('Failed to load coins: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load coins: $e');
    }
  }
}
