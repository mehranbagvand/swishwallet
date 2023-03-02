import 'package:get_storage/get_storage.dart';

import '../../../core/utils/utils.dart';
import '../../domain/entities/tokens.dart';

abstract class AuthLocalStorage {
  savePhoneNumber(String phoneNumber);

  String? getPhoneNumber();

  Tokens? getTokens();

  saveTokens(Tokens tokens);

  clear();
}

const _TOKENS_KEY = "tokens";
const _PHONE_NUMBER_KEY = "phonenumber";

class AuthLocalStorageImpl implements AuthLocalStorage {
  final storage = GetStorage("swish");

  @override
  Tokens? getTokens() {
    try {
      var rawTokens = storage.read<String>(_TOKENS_KEY);
      if (rawTokens == null) return null;
      Tokens tokens = Tokens.fromJson(rawTokens);
      return tokens;
    } catch (e, s) {
      logger.e("Error in getting local tokens", e, s);
      return null;
    }
  }

  @override
  saveTokens(Tokens tokens) async {
    await storage.write(_TOKENS_KEY, tokens.toJson());
    logger.d("Tokens saved: ${tokens.toJson()}");
  }

  @override
  String? getPhoneNumber() {
    try {
      return storage.read<String>(_PHONE_NUMBER_KEY);
    } catch (e, s) {
      logger.e("Error in getting local phone number", e, s);
      return null;
    }
  }

  @override
  savePhoneNumber(String phoneNumber) async {
    await storage.write(_PHONE_NUMBER_KEY, phoneNumber);
    logger.d("Phone number saved: $phoneNumber");
  }

  @override
  clear() async {
    await storage.erase();
  }
}
