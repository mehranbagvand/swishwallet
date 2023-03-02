import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens(this.accessToken, this.refreshToken);

  String get userId => Jwt.parseJwt(accessToken)["user_id"].toString();

  Map<String, dynamic> toMap() {
    return {
      'access': accessToken,
      'refresh': refreshToken,
    };
  }

  factory Tokens.fromMap(Map<String, dynamic> map) {
    return Tokens(
      map['access'],
      map['refresh'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tokens.fromJson(String source) => Tokens.fromMap(json.decode(source));

  Tokens copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    if ((accessToken == null || identical(accessToken, this.accessToken)) &&
        (refreshToken == null || identical(refreshToken, this.refreshToken))) {
      return this;
    }

    return Tokens(
      accessToken ?? this.accessToken,
      refreshToken ?? this.refreshToken,
    );
  }
}
