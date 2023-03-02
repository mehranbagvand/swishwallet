import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/auth/presentation/pages/pass_screen.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/main.dart';
import 'package:swish/splash/presentation/pages/init_page_screen.dart';
 import '../../../user/presentation/pages/profile_screen.dart';
import '../manager/splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put<SplashController>(
      SplashController(
          onTokensNotExistsUiCallback: onTokensNotExists,
          onProfileNotExitsUiCallback: onProfileNotExists,
          // onVersionUpdate: onVersionUpdate,
          onPassNotSet: onPassNotSet,
          onPassEnter: onPassEnter,
          onElseUiCallback: onElse),
    );
    controller.checkEssentials();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Images.bgSplash.patch, ), fit: BoxFit.fill)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Obx(() => controller.splashState.value == SplashState.loading
                ? _loadingStateWidget()
                : _failedStateWidget())),
      ),
    );
  }

  Widget _failedStateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Failed!"),
        TextButton(
            onPressed: controller.checkEssentials, child: const Text("Try again")),
        const Text("Do you want to exit?"),
        TextButton(
            onPressed: controller.clearUser, child: const Text("Logout"))
      ],
    );
  }

  Widget _loadingStateWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
       const ShowMedia(Images.logo),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              checkBox(value: true, text: "Implementation of buy "
                  "token and sell token pages", isNew: true),
              checkBox(value: true, text: "Implementation of ask "
                  "token and send token pages from people", isNew: true),
              checkBox(value: true, text: "Implementation of the success page UI", isNew: true),
              checkBox(value: true, text: "implementation of payment front and token receipt"),
              checkBox(value: false, text: "Adding a card on the stripe site in backend"),
              // checkBox(value: false, text: "Adding a card on the stripe site in backend"),
              // checkBox(value: false, text: "Adding a card on the stripe site in backend"),
              checkBox(value: false, text: "List of contacts who have the "
                  "program installed for backend"),
              checkBox(value: false, text: "client contact connection with backend "),
              checkBox(value: false, text: "test and debug contact"),
            ],
          ),
        )
      ],
    );
  }

  onTokensNotExists() {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return Get.offAll(()=>const InitPageScreen());
    });
  }
  onPassNotSet() {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return Get.offAll(()=>const PassScreen(type: PassType.set));
    });
  }
  onPassEnter() {
    return Future.delayed(const Duration(milliseconds: 100), () {
      return Get.offAll(()=>const PassScreen(type: PassType.enter));
    });
  }

  onProfileNotExists() {
    return Future.delayed(const Duration(milliseconds: 100), () async {
      return Get.offAll(() => ProfileScreen(type: ProfileType.create));
    });
  }

  // onVersionUpdate(String version,bool isRequired) {
  //   return Future.delayed(const Duration(milliseconds: 100), () {
  //     return Get.offAll(() => VersionPage(isRequire: isRequired,version: version,));
  //   });
  // }

  onElse() => Future.delayed(const Duration(milliseconds: 100), () {
  return Get.offAll(()=>const MainPage());
  });

  checkBox({required bool value,
    required String text,bool? isNew}){
    return
      CheckboxListTile(
          title: !value?Text(text, style: TextStyle(
              color: isNew==true?Colors.blue:null
          ),):
          Text.rich(TextSpan(
              text: text,
              style: TextStyle(
                  color: isNew==true?Colors.blue:null
              ),
              children: const [
                TextSpan(
                    text: "   New",
                    style: TextStyle(color: Colors.red)
                )
              ]
          )),
          value: value,
          onChanged: (v){});
  }

}


