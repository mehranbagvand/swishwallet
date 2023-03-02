import 'dart:convert';
import 'package:swish/contacts/data/model/contact_model.dart';
import 'package:swish/core/service/authenticated_http_client.dart';


abstract class ContactRemoteDataSource {
  Future<List<ContactModel>> postConcreteContact(List<String> list);
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final CFAuthenticatedClient client;

  var api = "user/contacts";

  ContactRemoteDataSourceImpl({required this.client});


  @override
  Future<List<ContactModel>> postConcreteContact(List<String> list) async{
    var res = await client.post(api, {
      "contacts": list
    });
    var json = jsonDecode(res.bodyString!) as List;
    return json.map((e) => ContactModel.fromMap(e)).toList() ;
  }


}