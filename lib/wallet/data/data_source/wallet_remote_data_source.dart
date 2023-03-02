import '../../../core/service/authenticated_http_client.dart';



abstract class WalletRemoteDataSource {
   void postMoneyTransfer(Map<String, dynamic> map);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final CFAuthenticatedClient client;
  WalletRemoteDataSourceImpl({required this.client});

  var api = "wallet/send-token";

  @override
  void postMoneyTransfer(Map<String, dynamic> map) async{
    client.post(api, map);
  }
}