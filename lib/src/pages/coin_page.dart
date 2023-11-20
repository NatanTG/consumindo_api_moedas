import 'package:flutter/material.dart';

import '../controller/coin_controller.dart';
import '../models/coin_model.dart';

class CoinPage extends StatefulWidget {
  const CoinPage({super.key});

  @override
  State<CoinPage> createState() => _CoinPageState();
}

class _CoinPageState extends State<CoinPage> {
  final controller = CoinController();
  var input = '';

  @override
  void initState() {
    super.initState();
    controller.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getCoins();
    });
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    super.dispose();
  }

  Future<CoinModel?> _selectCoin(CoinModel model) {
    return showModalBottomSheet<CoinModel>(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return ListView.builder(
              itemCount: controller.value.coins.length,
              itemBuilder: (context, index) {
                final innerCoin = controller.value.coins[index];
                return ListTile(
                  title: Text(innerCoin.name),
                  selected: innerCoin == model,
                  onTap: () {
                    Navigator.of(context).pop(innerCoin);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = controller.value;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Conversor de moedas'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Moeda',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) => input = value,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final moeda = await _selectCoin(state.coinIn);
                      if (moeda != null) {
                        controller.selectCoinIn(moeda);
                      }
                    },
                    child: Text(state.coinIn.code),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      onPressed: controller.switchCoins,
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final moeda = await _selectCoin(state.coinOut);
                      if (moeda != null) {
                        controller.selectCoinOut(moeda);
                      }
                    },
                    child: Text(state.coinOut.code),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.toConvert(input),
                child: Text('Resultado: ${state.result}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
