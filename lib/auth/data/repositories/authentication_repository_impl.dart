import 'dart:async';
import '../../../core/utils/utils.dart';
import '../../domain/entities/authenication_payload.dart';
import '../data_sources/auth_local_storage.dart';
import '../data_sources/auth_remote_service.dart';
import '../../domain/entities/authentication_repository.dart';
import '../../domain/entities/tokens.dart';


class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthLocalStorage authLocalStorage;
  final AuthRemoteService authRemoteService;

  AuthenticationRepositoryImpl(this.authRemoteService, this.authLocalStorage,);

  @override
  Future<Tokens?> getTokens() async {
    return authLocalStorage.getTokens();
  }

  @override
  Future<bool> isAuthenticated() async {
    return authLocalStorage.getTokens() != null;
  }

  @override
  Future<bool> submitPhoneNumber(String phoneNumber) async {
    var res = await authRemoteService.submitPhoneNumber(phoneNumber);
    if(!res.isOk) return false;
    await authLocalStorage.savePhoneNumber(phoneNumber);
    return true;
  }

  @override
  Future<AuthenticationPayload> submitVerificationCode(
      String verificationCode) async {
    var phoneNumber = authLocalStorage.getPhoneNumber();
    var response = await authRemoteService.submitVerificationCode(
        phoneNumber!, verificationCode);

    var authenticationPayload = AuthenticationPayload.fromResponseJson(response.bodyString!);
    logger.d("AuthenticationRepositoryImpl", authenticationPayload.tokens.toJson());
    await authLocalStorage.saveTokens(authenticationPayload.tokens);
    return authenticationPayload;
  }

  @override
  Future<void> resendVerificationCode() async {
    await submitPhoneNumber((authLocalStorage.getPhoneNumber())!);
  }

  @override
  Future<String?> getSubmittedPhoneNumber() async {
    return authLocalStorage.getPhoneNumber();
  }
}


