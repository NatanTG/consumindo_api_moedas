import 'dart:convert';

import 'package:http/http.dart';
import 'package:xml/xml.dart';

import '../models/coin_model.dart';

class CoinRepository {
  final client = Client();
  Future<List<CoinModel>> getCoins() async {
    final response = await client.get(
        Uri.parse('https://economia.awesomeapi.com.br/xml/available/uniq'));
    final xmlRaw = response.body;
    return parseCoins(xmlRaw);
  }

  List<CoinModel> parseCoins(String xmlRaw) {
    final document = XmlDocument.parse(xmlRaw);

    //estava pegando o primeiro elemento do xml
    final elements = document.children.last.children.whereType<XmlElement>();
    final coins = <CoinModel>[];

    for (var element in elements) {
      final model = CoinModel(
        //code estava ao contrario
        code: element.localName,
        name: element.innerText,
      );
      coins.add(model);
    }
    //estava retornando um array vazio
    return coins;
  }

  Future<double> quotation(CoinModel coinIn, CoinModel coinOut) async {
    final search = '${coinIn.code}-${coinOut.code}';

    final response = await client
        .get(Uri.parse('https://economia.awesomeapi.com.br/json/last/$search'));
    final jsonRaw = response.body;
    return parseQuotation(jsonRaw, search);
  }

  double parseQuotation(String jsonRaw, String search) {
    search = search.replaceFirst('-', '');
    final json = jsonDecode(jsonRaw);
    final model = json[search];
    final quotation = model['bid'];
    return double.parse(quotation);
  }
}
