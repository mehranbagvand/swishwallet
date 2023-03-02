import 'dart:convert';
import 'package:swish/core/service/authenticated_http_client.dart';
import '../../../core/utils/utils.dart';
import '../models/person_model.dart';
import 'package:dio/dio.dart' as dio;

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> postConcreteProfile(ProfileModel profile);
  Future<ProfileModel> editConcreteProfile(ProfileModel profile);
  Future<ProfileModel> getConcreteProfile();
  Future<bool> upConcreteAvatar(int id, dio.FormData body);
  Future<bool> deleteConcreteAvatar(int id);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final CFAuthenticatedClient client;

  var api = "user/profile";
  var apiAvatar = "user/profile-avatar";

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<ProfileModel> editConcreteProfile(ProfileModel profile)async {
    var res = await client.patch(api, profile.toMapEdit());
    var json = jsonDecode(res.bodyString!);
    return ProfileModel.fromMap(json);
  }
  @override
  Future<ProfileModel> getConcreteProfile() async{
    var res = await client.get(api);
    var json = jsonDecode(res.bodyString!);
    return ProfileModel.fromMap(json);
  }

  @override
  Future<ProfileModel> postConcreteProfile(ProfileModel profile) async{
    var res = await client.post(api, profile.toMap());
    var json = jsonDecode(res.bodyString!);
    return ProfileModel.fromMap(json);
  }

  @override
  Future<bool> deleteConcreteAvatar(int id) async{
      var response = await client.delete(apiAvatar);
      return response.isOk;
  }

  @override
  Future<bool> upConcreteAvatar(int id, body) async{
    logger.d(apiAvatar);
    try{
      var response = await client.postFormData(apiAvatar, body);
      logger.d(response.body);
      return response.isOk;
    }catch(e, s){
      logger.d(apiAvatar);
      logger.d(e);
      logger.d(s);
      throw "";
    }
  }

}