import 'package:consumindo_api/src/repositories/coin_repository.dart';
import 'package:flutter/material.dart';

import '../models/coin_model.dart';
import '../states/coin_state.dart';

class CoinController extends ValueNotifier<CoinState> {
  final repository = CoinRepository();

  CoinController() : super(CoinState.init());

  Future<void> getCoins() async {
    final coins = await repository.getCoins();
    value = value.copyWith(coins: coins);
  }

  Future<void> toConvert(String valueRaw) async {
    final quotation = await repository.quotation(value.coinIn, value.coinOut);
    final valueCoin = double.parse(valueRaw);
    final result = valueCoin * quotation;

    value = value.copyWith(result: result.toStringAsFixed(2));
  }

  Future<void> selectCoinIn(CoinModel model) async {
    value = value.copyWith(coinIn: model);
  }

  Future<void> selectCoinOut(CoinModel model) async {
    value = value.copyWith(coinOut: model);
  }

  void switchCoins() {
    value = value.copyWith(
      coinIn: value.coinOut,
      coinOut: value.coinIn,
    );
  }
}
