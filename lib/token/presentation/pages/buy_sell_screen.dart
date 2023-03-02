import 'package:flutter/material.dart';
import 'package:swish/core/enums/app_enum.dart';
import 'package:swish/core/images/images.dart';

import '../../../card/presentation/widgets/card_list_widget.dart';
import '../../../main.dart';

class BuySellScreen extends StatefulWidget {
  const BuySellScreen({Key? key, required this.type}) : super(key: key);
  final BuySell type;

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  final textController = TextEditingController();
  get sState => setState((){});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body:Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 6),
            _tabPage(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Select a card", style: TextStyle(
                      color: Color(0xff0A1820), fontSize: 16
                      ,fontWeight: FontWeight.w800),),
                  CardListWidget(noAdd: true)
                ],
              ),
            ),
            const Spacer(),
            const Text("META TOKENS :", style: TextStyle(
                color: Color(0xff1D1D1D),
                fontWeight: FontWeight.bold,
                fontSize: 14
            ),),
            const Spacer(),
            _countMoney(),
            const SizedBox(height: 30),
            Text("Price in USD: ${r"$"+_convertToUsd()}", style:
            const TextStyle(color: Color(0xff8B8B8B), fontSize: 16)),
            Text("Fee: ${r"$"+_fee()}", style:
            const TextStyle(color: Color(0xff828282), fontSize: 14)),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 343,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ElevatedButton(onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPage(forRes: true),
                      )), child: Text(widget.type==BuySell.buy?"Buy Now":"Withdraw",
                    style: const TextStyle(color: Color(0xff333333),
                        fontSize: 16, fontWeight: FontWeight.w700),)),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
    );
  }

  _tabPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                Text(widget.type==BuySell.sell?"Cash Out"
                    :"Buy Token", style: const TextStyle(
                  color: Color(0xff0A1820),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),),
                const SizedBox(height: 8),
                Text(widget.type==BuySell.sell?
                "Send money to your bank":"Buy MT token using your card.",
                  style: const TextStyle(
                  color: Color(0xff819099),
                  fontSize: 16,
                ),),
              ],
            ),
          ),
          SizedBox(
              width: 84,
              height: 84,
              child: ShowMedia(widget.type==BuySell.buy
                  ?Images.buyToken:Images.cashOut))
        ],
      ),
    );
  }

  Widget _countMoney(){
    return Container(
      width: 340,
      height: 80,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(16)
      ),
      child: SizedBox(
        width: 340,
        child: Row(
          children: [
            IconButton(onPressed: ()=>changeMoney(false),
                icon: const Icon(Icons.remove), iconSize: 30),
            const Spacer(),
            SizedBox(
              width: 120 ,
              child: TextFormField(
                controller: textController,
                textAlign: TextAlign.center,
                onChanged: (v)=>sState,
                maxLength: 7,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1D1D1D)
                ),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFAFAFA))
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFAFAFA))
                  ),
                  // errorBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white)
                  // )
                ),
              ),
            ),
            const Spacer(),
            IconButton(onPressed: ()=>changeMoney(true),
                icon: const Icon(Icons.add), iconSize: 30),
          ],
        ),
      ),
    );
  }

  String _convertToUsd(){
    var count = int.tryParse(textController.text)??0;
    return (count/2).toString();
  }
  String _fee(){
    var count = int.tryParse(textController.text)??0;
    return (count/100).toString();
  }

  void changeMoney(bool hasInc){
    var count = int.tryParse(textController.text)??0;
    if((count==0&&!hasInc)||(count==9999999&&hasInc)) return;
    textController.text ="${hasInc?(count+1):(count-1)}";
    sState;
  }
}
