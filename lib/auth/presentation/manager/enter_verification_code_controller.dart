import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_user_consent/sms_user_consent.dart';
import 'package:swish/auth/presentation/pages/pass_screen.dart';
import '../../../core/errors/api_call_exception.dart';
import '../../../core/utils/ui/ui_util.dart';
import '../../../core/utils/utils.dart';
import '../../../splash/presentation/pages/splash_screen.dart';
import '../../domain/entities/authentication_repository.dart';

var initialTimerVerify = 120;

class EnterVerificationCodeController extends GetxController {

  final AuthenticationRepository authenticationRepository;

  final verificationCode = "".obs;
  final controllerText = TextEditingController();
  final resendTimer = initialTimerVerify.obs;


  EnterVerificationCodeController(this.authenticationRepository);

  @override
  void onClose() {
    controllerText.dispose();
    super.onClose();
  }


  @override
  onInit() {
    super.onInit();
    startListeningToIncomingCode();
    restartTimer();
  }

  submitVerificationCode() async {
    try {
      await AppLoading.loadingOn(() async {
        await authenticationRepository.submitVerificationCode(verificationCode.string);
        return;
      });
     await 0.5.delay();
      Get.offAll(() => const PassScreen(type: PassType.set));
    } on UnauthorizedError {
      logger.d("The verification code is not correct or has expired");
     AppSnackBar.snackBar(
          "Error".tr, "The verification code is not correct or has expired".tr);
    } catch (e) {
      // AppSnackBar.snackBar("Error".tr, e.toString());
    }
  }

  restartTimer() {
    resendTimer.value = initialTimerVerify;
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        resendTimer.value = resendTimer.value - 1;
        if (resendTimer.value < 1) {
          timer.cancel();
        }
      },
    );
  }

  resendVerificationCode() async {
      await AppLoading.loadingOn(authenticationRepository.resendVerificationCode);
      restartTimer();
      // startListeningToIncomingCode();
  }

  startListeningToIncomingCode() async{
    if(osDeviceApp!=OsUser.web){
    var smsUserConsent = SmsUserConsent();
    smsUserConsent.requestSms();
    smsUserConsent.updateSmsListener(() => _onReceivedSms(smsUserConsent.receivedSms));
    }
  }

  _onReceivedSms(String? smsContent) {
    if (smsContent == null) {
      return;
    }
    String extractedOtp = smsContent.split(":")[1].trim();
    verificationCode.value = extractedOtp;
    controllerText.text = extractedOtp;
    submitVerificationCode();
  }


}

