import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/card/presentation/manager/card_controller.dart';
import '../page/add_card_screen.dart';
import '../../../core/enums/app_enum.dart';
import '../../../core/widgets/card_placeholder.dart';

class CardListWidget extends StatelessWidget {
  const CardListWidget({Key? key, this.noAdd = false, this.cardController})
      : super(key: key);
  final bool noAdd;
  final CardController? cardController;

  @override
  Widget build(BuildContext context) {
    if (cardController!.cards == null) {
      return placeHolderCard();
    }
    if (cardController!.cards != null &&
        cardController!.cards!.isEmpty &&
        !noAdd) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_addCardNew(context)],
      );
    }
    return Container(
        width: Get.width,
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            if (!noAdd)
              Flexible(
                flex: 4,
                child: _addCardNew(context),
              ),
            Flexible(
              flex: 10,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: cardController?.cards!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = cardController!.cards![index];
                    return Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: cardItem(
                          name: item.nameOnCard,
                          type: CardType.master,
                          numberCard: "***${item.cardNumber.substring(12, 16)}",
                          date: item.expiryDate),
                    );
                  }),
            )
          ],
        ));
  }



  cardItem(
      {required String name,
      required CardType type,
      required String numberCard,
      required String date}) {
    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(10), child: type.bg),
        Container(
          width: 209,
          height: 95,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  type.icon,
                  const Spacer(),
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    numberCard,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w200),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  _addCardNew(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddCardScreen(),
        ),
      ),
      child: Container(
        width: 95,
        height: 95,
        margin: const EdgeInsetsDirectional.only(start: 16),
        decoration: const BoxDecoration(
            color: Color(0xffF9F9FB),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 12),
              const Text("Add Card")
            ],
          ),
        ),
      ),
    );
  }

  Widget placeHolderCard(){
    return Container(
      width: Get.width,
      height: 100,
      margin: const EdgeInsetsDirectional.only(start: 11),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (BuildContext context,int index){
        return const CardPlaceholderView();
      }),
    );
  }
}



class CardItemWidget extends StatelessWidget {
  const CardItemWidget(
      {Key? key,
      required this.name,
      required this.type,
      required this.numberCard,
      required this.date})
      : super(key: key);
  final String name;
  final CardType type;
  final String numberCard;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(borderRadius: BorderRadius.circular(10), child: type.bg),
        Container(
          width: 209,
          height: 95,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  type.icon,
                  const Spacer(),
                  Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    numberCard,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w100),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
