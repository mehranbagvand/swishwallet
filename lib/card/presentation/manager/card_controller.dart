import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:swish/core/usecases/use_case.dart';
import '../../../core/utils/utils.dart';
import '../../../injection_container.dart';
import '../../../main.dart';
import '../../data/model/card_model.dart';
import '../../domain/entities/card.dart';
import '../../domain/use_cases/card_use_cases.dart';

class CardController extends GetxController {
  static CardController get instance => Get.isRegistered<CardController>()
      ? Get.find<CardController>() : Get.put(CardController());



  final GetConcreteCard _getConcreteCard = sl();
  final PostConcreteCard _postConcreteCard = sl();

  List<Card>? cards;

  int? year;
  int? month;

  set setTime(DateTime value){
    year = value.year;
    month = value.month;
    update(["time"]);
  }


  Future getCards() async {
    try{
      var profile = await _getConcreteCard(NoParams());
      cards = profile.toIterable().first;
      logger.d("list : $cards ");
      update(['card']);
    }on Exception catch (e){
      logger.e(e);
    }
  }

  Future createCard(CardModel card) async {
    try{
      EasyLoading.show(status: "Please waite...");
      var res = await _postConcreteCard(card);
      if(res.isRight()){
        Get.offAll(const MainPage(forRes: true,));
      }
    }on Exception catch (e){
      logger.e(e);
    }
    EasyLoading.dismiss();
  }
}
