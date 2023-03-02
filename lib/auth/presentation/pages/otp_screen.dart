import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/utils.dart';
import '../../data/data_sources/auth_remote_service.dart';
import '../../data/repositories/authentication_repository_impl.dart';
import '../manager/enter_verification_code_controller.dart';
import 'login_screen.dart';


class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  final EnterVerificationCodeController controller =
  Get.put(EnterVerificationCodeController(AuthenticationRepositoryImpl(
    AuthRemoteServiceImpl(),
    Get.find(),
  )))!;

  final _formStateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00012C),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image:
            AssetImage(Images.authBg.patch),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appBar(),
            _detailMainPage(context)
          ],
        ),
      ),

    );
  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 21)
          .add(EdgeInsets.only(top: sizeForMobileStatusBar)),
      child: Column(
        children: const[
          ShowMedia(Images.logo),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  _detailMainPage(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.only(topLeft: Radius.circular(24),
              topRight: Radius.circular(24), )),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Spacer(),
              Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom<=0,
                  child: const Center(child: ShowMedia(Images.numberOTP, width: 122,))),
              const Spacer(),
              const Text("OPT Code", style: TextStyle(
                color: Color(0xff4F89EA),
                fontSize: 22
              ),),
              const Spacer(),
              Form(
                key: _formStateKey,
                child: PinInputTextField(
                  pinLength: 4,
                  controller: controller.controllerText,
                  keyboardType: TextInputType.number,
                  decoration: const UnderlineDecoration(colorBuilder:
                  FixedColorBuilder(Color(0xff4F89EA)),
                    hintText: "****"
                  ),
                  onChanged: (v){
                    controller.verificationCode.value = v;
                  },
                  onSubmit: (v){
                    controller.submitVerificationCode();
                  },
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 343,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                         primary: const Color(0xff2260F5)),
                        onPressed: (){
                       if(controller.verificationCode.value.length!=4) return;
                         controller.submitVerificationCode();
                    },
                        child: const Text("Continue")),
                  ),
                ),
              ),
              const Spacer(),
              if (controller.resendTimer < 1)GestureDetector(
                onTap: () {
                  if(!(_formStateKey.currentState?.validate()??false)) return;
                  controller.resendVerificationCode();
                  },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Send Again", style: TextStyle(
                      color: Color(0xff8B8B8B)
                    ),),
                    Icon(Icons.arrow_circle_right_outlined,
                      color: Color(0xff8B8B8B),),
                      ],
                ),
              ),
              if (controller.resendTimer > 1)
                Obx(() =>Text(controller.resendTimer.secondsToTime(),
                    style: TextStyle(
                        color: Theme.of(context).disabledColor)),
                )
            ],
          ),
        ),
      ),
    );
  }
  void onResend() {
    controller.resendVerificationCode();
  }

}

extension _IntExt on RxInt {

  secondsToTime() {
    var m = this ~/ 60;
    var s = this % 60;
    return "${m<10?"0$m":m}:${s<10?"0$s":s}";
  }
}
