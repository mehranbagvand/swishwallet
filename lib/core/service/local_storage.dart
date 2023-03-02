import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:swish/user/data/models/person_model.dart';
import '../../auth/data/data_sources/auth_local_storage.dart';
import '../../user/domain/entities/profile.dart';
import '../utils/utils.dart';

const _PROFILE_KEY = "profile";

class LocalStorage {
  final GetStorage _storage;
  final AuthLocalStorage _authLocalStorage;
  LocalStorage({GetStorage? storage,
    AuthLocalStorage? authLocalStorage
  }): _storage = storage ?? GetStorage("swish"),
        _authLocalStorage = authLocalStorage ?? Get.find();

  setVersion(String v){
    _storage.write("version", v);
  }

  getVersion(){
    return _storage.read("version");
  }

  setPassword(String v){
    _storage.write("password", v.hashCode);
  }

  bool checkPassword(String v){
    return v.hashCode == _storage.read("password");
  }
  bool passIsSet(){
    return _storage.read("password") != null;
  }


  saveProfile(Profile profile) async {
    await _storage.write(_PROFILE_KEY, profile.model.toMap());
  }

  ProfileModel? getProfile() {
    try {
      var raw = _storage.read(_PROFILE_KEY);
      if (raw == null) return null;
      return ProfileModel.fromMap(raw);
    } catch (e, s) {
      logger.d("Error in getting profile locally", e, s);
    }
    return null;
  }

  clear() async {
    await _authLocalStorage.clear();
    await _storage.erase();
    logger.d(_authLocalStorage.getPhoneNumber());
  }
}
