import 'package:get/get.dart';
import '../../../core/service/http_client.dart';

abstract class AuthRemoteService {
  Future<Response> submitPhoneNumber(String phoneNumber);

  Future<Response> submitVerificationCode(
      String phoneNumber, String verificationCode);
}

class AuthRemoteServiceImpl implements AuthRemoteService {
  static const PHONE_API = "auth/register";
  static const VERIFICATION_CODE_API = "auth/verify";

  final HttpClient client;

  AuthRemoteServiceImpl({int? port, HttpClient? client})
      : client = client ?? HttpClient(port: port);

  @override
  Future<Response> submitPhoneNumber(String phoneNumber) {
    return client.post(PHONE_API, {
      'phone_number': phoneNumber,});
  }

  @override
  Future<Response> submitVerificationCode(
      String phoneNumber, String verificationCode) {
    return client.post(VERIFICATION_CODE_API,
        {'phone_number': phoneNumber, 'code': verificationCode});
  }
}
