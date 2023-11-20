import 'package:equatable/equatable.dart';

class CoinModel extends Equatable {
  final String name;
  final String code;
  const CoinModel({
    required this.name,
    required this.code,
  });

  factory CoinModel.init() {
    return const CoinModel(code: '', name: '');
  }

  @override
  List<Object?> get props => [name, code];
}
