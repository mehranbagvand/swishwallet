import 'dart:convert';
import 'package:swish/core/service/authenticated_http_client.dart';

import '../model/card_model.dart';

abstract class CardRemoteDataSource {
  Future<CardModel> postConcreteCard(CardModel cardModel);
  Future<List<CardModel>> getConcreteCard();
}

class CardRemoteDataSourceImpl implements CardRemoteDataSource {
  final CFAuthenticatedClient client;

  var api = "wallet/cards";

  CardRemoteDataSourceImpl({required this.client});


  @override
  Future<List<CardModel>> getConcreteCard() async{
    var res = await client.get(api);
    var json = jsonDecode(res.bodyString!) as List;
    return json.map((e) => CardModel.fromMap(e)).toList();
  }

  @override
  Future<CardModel> postConcreteCard(CardModel cardModel) async{
    var res = await client.post(api, cardModel.toMap());
    var json = jsonDecode(res.bodyString!);
    return CardModel.fromMap(json);
  }


}