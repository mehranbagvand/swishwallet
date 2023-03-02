


import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swish/core/utils/utils.dart';
import 'package:swish/wallet/domain/use_cases/wallet_use_cases.dart';

import '../../../injection_container.dart';

class WalletController extends GetxController{
  static WalletController get instance => Get.isRegistered<WalletController>()
      ? Get.find<WalletController>() : Get.put(WalletController());


  final PostConcreteWallet _postConcreteWallet = sl();



  Future<bool> sendMoney(Map<String,dynamic> map) async{
    EasyLoading.show(status: "Please Wait...");
    try{
      _postConcreteWallet(map);
      EasyLoading.dismiss();
      return true;
    } on Exception catch (e){
      logger.e(e);
      EasyLoading.dismiss();
      return false;
    }
  }

}