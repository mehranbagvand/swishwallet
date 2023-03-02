import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/auth/data/data_sources/auth_local_storage.dart';
import 'package:swish/card/presentation/manager/card_controller.dart';
import 'package:swish/core/enums/app_enum.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/card/presentation/widgets/card_list_widget.dart';
import 'package:swish/token/presentation/pages/buy_sell_screen.dart';

import '../../../core/service/local_storage.dart';
import '../../../core/utils/utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image:
            AssetImage(Images.homeBg.patch),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)

        ),
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appBar(),
            _walletMoney(context)
          ],
        ),
      ),
    );
  }

  _appBar() {
    var p = Get.find<LocalStorage>().getProfile()!;
    return Flexible(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.symmetric(vertical: 35)
            .add(EdgeInsets.only(top: sizeForMobileStatusBar)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome back",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    )),
                const SizedBox(height: 7),
                Text(p.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    )),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: ()=> Get.find<AuthLocalStorage>().clear(),
              child: p.avatar(radius: 27),
            ),
          ],
        ),
      ),
    );
  }

  _walletMoney(BuildContext context){
    return Flexible(
      flex: 15,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image:
              AssetImage(Images.bgMoney.patch), fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter),
              borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(75))),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Wrap(
                      spacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      children: [
                        const ShowMedia(Images.bankMoney, width: 100,),
                        Column(
                          children: const [
                            Text("2030 MT",
                                style: TextStyle(
                                    fontSize: 45, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Text(
                              "Available balance",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black38),
                            )
                          ],
                        )
                      ],
                    )),
                _detailMainPage(context)
              ],
            ),
          ),
        ));
  }

  _detailMainPage(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.only(topLeft: Radius.circular(75))),
      child: Column(
        children: [
          _buyCashOut(context),
          GetBuilder<CardController>(
            id: "card",
            init: CardController.instance..getCards(),
            builder: (con) {
              return CardListWidget(cardController: con,);
            }
          ),
          _history(),
        ],
      ),
    );
  }

  _buyCashOut(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 33),
      child: Wrap(
        spacing: 26,
        alignment: WrapAlignment.center,
        children: [
          itemTile(context,icon: const ShowMedia(Images.profit),type: BuySell.buy,
              title: "Buy Tokens", color: const Color(0xff92D3F0)),
          itemTile(context,icon: const ShowMedia(Images.bank),type: BuySell.sell,
              title: "Cash Out", color:const Color(0xffFCA77B)),
        ],
      ),
    );
  }

  _history(){
    return Container(
      padding: const EdgeInsets.only(top: 35),
      margin: const EdgeInsetsDirectional.only(start: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          spacing: 8,
          children: [
            _itemHistory(25, CountAction.decrease),
            _itemHistory(87, CountAction.increase),
            _itemHistory(15, CountAction.increase),
            _itemHistory(69, CountAction.decrease),
            _itemHistory(15, CountAction.increase),
            _itemHistory(69, CountAction.decrease),
          ],
        ),
      ),);
  }

  _itemHistory(int count, CountAction action){
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 13),
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Color(0xffF9F9FB),
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: action.color
              ),
              child: action.icon
          ),),
        Positioned(
          top: -1,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xffFDBE44).withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(8))
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: Text("${action.text}$count"),),
        ),
      ],
    );

  }

  itemTile(BuildContext context,{required Widget icon,required BuySell type,
    required String title,required Color color}){
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BuySellScreen(type: type),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle
            ),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: icon
            ),
          ),
          const SizedBox(height: 12),
          Text(title)
        ],
      ),
    );
  }
}
