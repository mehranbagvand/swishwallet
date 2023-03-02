import 'package:get/get.dart';
import 'package:swish/user/domain/user_domain.dart';
import '../../../../core/utils/utils.dart';
import '../../../auth/data/data_sources/auth_local_storage.dart';
import '../../../core/errors/api_call_exception.dart';
import '../../../core/service/local_storage.dart';
import '../../../core/usecases/use_case.dart';
import '../../../injection_container.dart';
import '../pages/splash_screen.dart';

enum SplashState { idle, loading, failed }

class SplashController extends GetxController {
  final Function? onTokensNotExistsUiCallback;
  final Function? onPassNotSet;
  final Function? onPassEnter;
  final Function? onElseUiCallback;
  final LocalStorage cfCommonLocalStorage;
  final Function? onProfileNotExitsUiCallback;
  final Function? onVersionUpdate;
  final AuthLocalStorage authLocalStorage;
  // final ProfileService profileService;

  SplashController(
      {LocalStorage? cfCommonLocalStorage,
      AuthLocalStorage? authLocalStorage,
      // ProfileService? profileService,
      this.onTokensNotExistsUiCallback,
        this.onProfileNotExitsUiCallback,
        this.onVersionUpdate,
        this.onPassEnter,
        this.onPassNotSet,
        this.onElseUiCallback})
      : cfCommonLocalStorage = cfCommonLocalStorage ?? Get.find(),
        authLocalStorage = authLocalStorage ?? Get.find();
        // profileService = profileService ?? Get.find();

  final splashState = SplashState.loading.obs;

  clearUser()async{
    await authLocalStorage.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      return Get.offAll(() => const SplashPage());
    });
  }

  checkEssentials() async {
    splashState.value = SplashState.loading;
    try {
      // if(!GetPlatform.isWeb&&!GetPlatform.isDesktop){
      //   var response = await Dio().get(HOST_URL + "app-version/");
      //   Map versionData = json.decode(response.toString());
      //
      //   String v = await version();
      //   if (v != versionData['version']) {
      //     return onVersionUpdate?.call(
      //         versionData['version'], versionData['is_required']);
      //   }
      // }
      // if(VERSION!=cfCommonLocalStorage.getVersion()){
      //   cfCommonLocal Storage.setVersion(VERSION);
      // }
      await 3.delay();
      if (authLocalStorage.getTokens() == null) {
        logger.d("Tokens not exists");
        return onTokensNotExistsUiCallback?.call();
      }
      logger.d("Phone number is:${authLocalStorage.getPhoneNumber()}");
      if (cfCommonLocalStorage.getProfile() == null) {
        logger.d(
            "Profile not exists locally \n Trying to get profile from server");
        try {
          GetConcreteProfile getProfile = sl();
          Profile profile = (await getProfile(NoParams()))
              .toIterable()
              .first;
          cfCommonLocalStorage.saveProfile(profile);
        } on NotFoundError {
          logger.d("Profile was not found on server");
          return onProfileNotExitsUiCallback?.call();
        }
      }

      if(cfCommonLocalStorage.passIsSet()){
       onPassEnter?.call();
      }else{
       onPassNotSet?.call();
      }
      // onElseUiCallback?.call();
      } catch (e, s) {
        logger.e("An error occurred", e, s);
        splashState.value = SplashState.failed;
        return;
      }
  }

}
