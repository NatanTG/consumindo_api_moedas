// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../models/coin_model.dart';

class CoinState {
  final List<CoinModel> coins;

  final CoinModel coinIn;
  final CoinModel coinOut;

  final String result;
  CoinState({
    required this.coins,
    required this.coinIn,
    required this.coinOut,
    required this.result,
  });

  factory CoinState.init() {
    return CoinState(
      coinIn: CoinModel.init(),
      coinOut: CoinModel.init(),
      coins: const [],
      result: '0',
    );
  }

  CoinState copyWith({
    List<CoinModel>? coins,
    CoinModel? coinIn,
    CoinModel? coinOut,
    String? result,
  }) {
    return CoinState(
      coins: coins ?? this.coins,
      coinIn: coinIn ?? this.coinIn,
      coinOut: coinOut ?? this.coinOut,
      result: result ?? this.result,
    );
  }
}
