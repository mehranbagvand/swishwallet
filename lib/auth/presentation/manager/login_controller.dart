import 'package:get/get.dart';
import 'package:swish/core/utils/ui/ui_util.dart';
import '../../data/data_sources/auth_local_storage.dart';
import '../../domain/entities/authentication_repository.dart';
import '../pages/otp_screen.dart';

class LoginController extends GetxController{
  LoginController(this.authenticationRepository, this.authLocalStorage);
  final AuthLocalStorage authLocalStorage;
  final AuthenticationRepository authenticationRepository;

  RxString phoneNumber = ''.obs;

  submitPhone() async {
    bool response = false;
    try{
      await AppLoading.loadingOn(() async {
        response = await authenticationRepository.submitPhoneNumber(phoneNumber.value);
      });
      if(!response) return;
      Get.to(() => OTPScreen(phoneNumber: phoneNumber.value));
    }catch(e){
      return;
    }
  }

}