import 'package:swish/auth/domain/entities/tokens.dart';
import 'authenication_payload.dart';

abstract class AuthenticationRepository {
  Future<bool> isAuthenticated();

  Future<Tokens?> getTokens();

  Future<bool> submitPhoneNumber(String phoneNumber);

  Future<AuthenticationPayload> submitVerificationCode(String verificationCode);

  Future<void> resendVerificationCode();

  Future<String?> getSubmittedPhoneNumber();
}
