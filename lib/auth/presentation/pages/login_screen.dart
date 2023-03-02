import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/auth/presentation/manager/login_controller.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/utils.dart';
import '../../data/data_sources/auth_remote_service.dart';
import '../../data/repositories/authentication_repository_impl.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  checkOTP(BuildContext context) {
    controller.submitPhone();
  }

  final controller = Get.put(LoginController(AuthenticationRepositoryImpl(
      AuthRemoteServiceImpl(), Get.find()), Get.find()));

  final _formStateKey = GlobalKey<FormState>();
  var countryCode = "+47".obs;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Welcome to Fynance", style: TextStyle (
                fontSize: 22, fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 12),
              const Text("Enter your phone number"
                  " to login or register", style: TextStyle(
                  fontSize: 14, color: Color(0xff8B8B8B)
              ),),
              const Spacer(),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom<=0,
                child: const Center(child: ShowMedia(Images.numberAuth, width: 122,)),
              ),
              // const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          onSelect: (Country country) {
                            print('Select country: ${country.displayName}');
                            countryCode.value ="+${country.phoneCode}";
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Obx(() => Text(countryCode.value, style: const TextStyle(
                              color: Color(0xff8B8B8B),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),),
                          ),
                          const Icon(Icons.arrow_drop_down,
                            color: Color(0xff8B8B8B),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Form(
                          key: _formStateKey,
                          child: TextFormField(
                            validator: (value) => isMobileNumberValid(value??""),
                            decoration: const InputDecoration(
                              counterText: ""
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (v){
                              controller.phoneNumber.value = "$countryCode$v";
                            },
                            onFieldSubmitted: (v){
                              controller.phoneNumber.value = "$countryCode$v";
                             if(isMobileNumberValid(v)==null) {
                                if (v == "9921033258") {
                                  controller.phoneNumber.value =
                                      "+989921033258";
                                }
                                checkOTP(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Text.rich(
                 textAlign: TextAlign.center,
                  TextSpan(text: "By using Swish you agree to Swish’s ",
                    style: TextStyle(fontSize: 12),
                    children: [
                      TextSpan(text: "terms and conditions",
                          style: TextStyle(
                              color: Color(0xffFDBE44),
                              fontSize: 12
                          )
                      )
                    ]),
                ),
              ),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: 343,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: ElevatedButton(onPressed: (){
                      if(!(_formStateKey.currentState?.validate()??false)) return;
                      checkOTP(context);
                    },
                        child: const Text("Continue")),
                  ),
                ),
              ),
              const SizedBox(height: 12)

            ],
          ),
        ),
      ),
    );
  }

  String? isMobileNumberValid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{8,12}$';
    var regExp = RegExp(regexPattern);
    if (phoneNumber.isEmpty) {
      return "The number is not entered correctly";
    } else if (regExp.hasMatch(phoneNumber)) {
      return null;
    }
    return "The number is not entered correctly";
  }

}
