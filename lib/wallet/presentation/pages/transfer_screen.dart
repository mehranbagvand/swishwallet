import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/core/enums/app_enum.dart';
import 'package:swish/core/widgets/text_field_widget.dart';
import 'package:swish/main.dart';
import 'package:swish/user/domain/entities/profile.dart';
import 'package:swish/wallet/presentation/manager/wallet_controller.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen(
      {Key? key,
      required this.profile,
      required this.type,
      required this.userId})
      : super(key: key);
  final Profile profile;
  final SendAsk type;
  final int userId;

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final textController = TextEditingController();

  get sState => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 45),
            const Text(
              "Type a message",
              style: TextStyle(fontSize: 16, color: Color(0xff2D2D2D)),
            ),
            const SizedBox(height: 15),
            CFTextField(
              hint: widget.type == SendAsk.ask
                  ? "Can you send me 100 MT token please?"
                  : "Go for some shopping today!",
              hintStyle:
                  const TextStyle(fontSize: 16, color: Color(0xff8B8B8B)),
              onTextChange: (v) {},
              textInputAction: TextInputAction.next,
            ),
            const Spacer(),
            Text(
              widget.type == SendAsk.ask ? "Ask For MT Token" : "Send MT Token",
              style: const TextStyle(
                  color: Color(0xff1D1D1D),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const Spacer(),
            _countMoney(),
            const SizedBox(height: 34),
            _selectMoney(),
            const SizedBox(height: 37),
            Text("Price in USD: ${r"$" + _convertToUsd()}",
                style: const TextStyle(color: Color(0xff8B8B8B), fontSize: 16)),
            const Spacer(),
            Center(
              child: SizedBox(
                width: 343,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ElevatedButton(
                      onPressed: () {
                        if (textController.text.isEmpty) {
                          Get.snackbar("OPS!", "amount should not be empty");
                          return;
                        }
                        WalletController.instance.sendMoney({
                          "to_user_id": widget.userId,
                          "amount": textController.text
                        }).then((value) {
                          if (value == true) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MainPage(forRes: true),
                                ));
                          }
                        });
                      },
                      child: Text(
                        widget.type == SendAsk.ask ? "Send Request" : "Send",
                        style: const TextStyle(
                            color: Color(0xff333333),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      )),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _countMoney() {
    return Container(
      width: 340,
      height: 80,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          color: const Color(0xffFAFAFA),
          borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: 340,
        child: Row(
          children: [
            IconButton(
                onPressed: () => changeMoney(false),
                icon: const Icon(Icons.remove),
                iconSize: 30),
            const Spacer(),
            SizedBox(
              width: 120,
              child: TextFormField(
                controller: textController,
                textAlign: TextAlign.center,
                onChanged: (v) => sState,
                maxLength: 7,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1D1D1D)),
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  counterText: "",
                  fillColor: Colors.white,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFAFAFA))),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFAFAFA))),
                  // errorBorder: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white)
                  // )
                ),
              ),
            ),
            const Spacer(),
            IconButton(
                onPressed: () => changeMoney(true),
                icon: const Icon(Icons.add),
                iconSize: 30),
          ],
        ),
      ),
    );
  }

  String _convertToUsd() {
    var count = int.tryParse(textController.text) ?? 0;
    return (count / 2).toString();
  }

  Widget _selectMoney() {
    item(int count) {
      return InkWell(
        onTap: () {
          textController.text = count.toString();
          sState;
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 98,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: const TextStyle(
                  color: Color(0xff1D1D1D),
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
      );
    }

    return Wrap(
      runSpacing: 16,
      spacing: 24,
      children: [
        item(20),
        item(50),
        item(100),
        item(200),
        item(500),
        item(1000),
      ],
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Wrap(
            spacing: 12,
            children: [
              widget.profile.avatar(notCircle: true, radius: 5),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.profile.name,
                    style: const TextStyle(
                        color: Color(0xff1D1D1D),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  Text(
                    widget.profile.phoneNumber,
                    style:
                        const TextStyle(color: Color(0xff8B8B8B), fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void changeMoney(bool hasInc) {
    var count = int.tryParse(textController.text) ?? 0;
    if ((count == 0 && !hasInc) || (count == 9999999 && hasInc)) return;
    textController.text = "${hasInc ? (count + 1) : (count - 1)}";
    sState;
  }
}
