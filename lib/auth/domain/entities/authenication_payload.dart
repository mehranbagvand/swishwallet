import 'dart:convert';
import 'package:swish/auth/domain/entities/tokens.dart';

class AuthenticationPayload {
  final Tokens tokens;
  AuthenticationPayload(this.tokens,
      );

  factory AuthenticationPayload.fromResponseMap(Map<String, dynamic> map) {
    return AuthenticationPayload(
        Tokens.fromMap(map),
    );
  }

  factory AuthenticationPayload.fromResponseJson(String source) =>
      AuthenticationPayload.fromResponseMap(json.decode(source));
}
