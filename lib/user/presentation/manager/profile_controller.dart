import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as di;
import 'package:swish/core/service/local_storage.dart';
import 'package:swish/core/usecases/use_case.dart';
import 'package:swish/core/utils/utils.dart';
import 'package:swish/splash/presentation/pages/splash_screen.dart';
import 'package:swish/user/data/models/person_model.dart';
import 'package:swish/user/domain/use_cases/profile_use_cases.dart';
import '../../../injection_container.dart';
import '../../../main.dart';
import '../../domain/entities/profile.dart';

class ProfileController extends GetxController {


  @override
  void onInit() {
   var p = storage.getProfile();
    if(p?.id!=null)profile = storage.getProfile()!.model;
    super.onInit();
  }

  LocalStorage storage = Get.find<LocalStorage>();

  GetConcreteProfile getConcreteProfile = sl();
  PostConcreteProfile postConcreteProfile = sl();
  EditConcreteProfile editConcreteProfile = sl();
  UpConcreteAvatar upConcreteAvatar = sl();
  DeleteConcreteAvatar deleteConcreteAvatar = sl();

  ProfileModel profileEdit = ProfileModel.empty();
  Profile profile = ProfileModel.empty();

  Uint8List? avatar = Uint8List(0);

  changeAvatar(Uint8List? uInt8list) async => avatar = uInt8list;

  late Future<Profile> futureProfile;

  Future<Profile> getProfile()async {
    var profile =await getConcreteProfile(NoParams());
    logger.d(profile);
    return this.profile = profile.toIterable().first;
  }

  Future<bool> createProfile() async {
    var res = await postConcreteProfile(profileEdit);
    if(res.isRight()){
      var p = res.toIterable().first;
      if (avatar != null && avatar!.isNotEmpty) await uploadImage(p.id!);
      storage.saveProfile(p);
      Get.offAll(const MainPage());
      return true;
    }
    return res.isRight();

  }

  Future<bool> editProfile() async {
    var id = storage.getProfile()?.id;
    var res = await editConcreteProfile(profileEdit);
    if(res.isRight()) {
      var p = res.toIterable().first;
      if (avatar != null && avatar!.isNotEmpty) await uploadImage(id!);
      if (avatar == null) await deleteImage(id!);
      storage.saveProfile(p);
      Get.back();
    }
    return res.isRight();
  }

  Future<bool> uploadImage(int id) async {
    di.FormData formData = di.FormData.fromMap({
      "avatar": di.MultipartFile.fromBytes(avatar!, filename: "image.png")});
    bool upload = (await upConcreteAvatar(AvatarParams(id, formData))).toIterable().first;
    return upload;
  }

  Future<bool> deleteImage(int id)async {
    var response = (await deleteConcreteAvatar(id)).toIterable().first;
    return response;
  }

  Future<bool> logOut()async{
    await storage.clear();
    Get.offAll(const SplashPage());
    return true;
  }

@override
  void dispose() {
    profile = ProfileModel.empty();
    profileEdit = ProfileModel.empty();
    super.dispose();
  }

}
