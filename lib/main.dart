import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:swish/card/presentation/manager/card_controller.dart';
import 'package:swish/core/config/themes/app_theme.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/injection_container.dart';
import 'package:swish/splash/presentation/pages/splash_screen.dart';
import 'package:swish/user/presentation/pages/profile_screen.dart';
import 'package:swish/wallet/presentation/manager/wallet_controller.dart';
import 'package:swish/wallet/presentation/pages/history_screen.dart';
import 'auth/data/data_sources/auth_local_storage.dart';
import 'contacts/presentation/manager/contact_controller.dart';
import 'core/service/authenticated_http_client.dart';
import 'core/service/local_storage.dart';
import 'home/presentation/pages/home_screen.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = PostHttpOverrides();
  await initDependencies();
  runApp(const MyApp());
}

const VERSION = "1.0.8";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'Swish',
      theme: AppTheme.basic,
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      builder: EasyLoading.init(),
    );
  }
}

initDependencies() async {
  await GetStorage.init("swish");
  var authLocalStorage = AuthLocalStorageImpl();
  Get
    ..put<AuthLocalStorage>(authLocalStorage, permanent: true)
    ..put<CFAuthenticatedClient>(CFAuthenticatedClient(Get.find()),
        permanent: true)
    ..put<LocalStorage>(LocalStorage(), permanent: true);
  init();
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, this.forRes = false}) : super(key: key);
  final bool forRes;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int indexPage = 1;

  @override
  void initState() {
    if (widget.forRes) indexPage = 3;
    Get.put(CardController());
    Get.put(ContactController());
    Get.put(WalletController());
    super.initState();
  }

  final List<Widget> listPages = [
    const HistoryScreen(),
    const HomeScreen(),
    ProfileScreen(type: ProfileType.onlyRead)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar,
      body: indexPage == 3
          ? Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Images.bgStatus.assetImage, fit: BoxFit.fill)),
              child: Center(
                child: Column(
                  children: [
                    const Spacer(),
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 100,
                      color: Color(0xff05E985),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Request sent successfully",
                      style: TextStyle(color: Colors.white, fontSize: 16),
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
                                backgroundColor: const Color(0xffA000EE),
                              ),
                              onPressed: () => setState(() => indexPage = 1),
                              child: const Text("Go back")),
                        ),
                      ),
                    ),
                    const SizedBox(height: 86),
                  ],
                ),
              ),
            )
          : listPages[indexPage],
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(25),
        topLeft: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        onTap: (index) => setState(() => indexPage = index),
        items: [
          BottomNavigationBarItem(
              icon: iconNav(Images.swish, active: indexPage == 0), label: ''),
          BottomNavigationBarItem(
              icon: iconNav(Images.bank, active: indexPage == 1), label: ''),
          BottomNavigationBarItem(
              icon: iconNav(Images.person, active: indexPage == 2), label: ''),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
    );
  }

  Widget iconNav(MediaAssets image, {required bool active}) {
    return Padding(
      padding: const EdgeInsets.only(top: 13.0),
      child: ShowMedia(
        image,
        color: Color(active ? 0xff2F80ED : 0xff1D1D1D),
        width: 24,
        height: 24,
      ),
    );
  }
}
