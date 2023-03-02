import '../entities/authenication_payload.dart';
import '../entities/tokens.dart';

abstract class AuthenticationRepository {
  Future<bool> isAuthenticated();

  Future<Tokens?> getTokens();

  Future<void> submitPhoneNumber(String phoneNumber);

  Future<AuthenticationPayload> submitVerificationCode(String verificationCode);

  Future<void> resendVerificationCode();

  Future<String?> getSubmittedPhoneNumber();
}
