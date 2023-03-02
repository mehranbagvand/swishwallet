import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:swish/card/data/model/card_model.dart';
import 'package:swish/card/presentation/manager/card_controller.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/core/widgets/text_field_widget.dart';



class AddCardScreen extends StatelessWidget {
  AddCardScreen({Key? key}) : super(key: key);
  final _formStateKey = GlobalKey<FormState>();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _cvv = TextEditingController();
  final TextEditingController _nameCard = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add New Card", style: TextStyle(fontSize: 18),),
        elevation: 0,
      ),
      body:GetBuilder<CardController>(
          id: "time",
          init: CardController.instance,
        builder: (controller) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 27.0),
                    child: ShowMedia(Images.cardImg, width: 214,height: 172,),
                  ),
                  Form(
                    key: _formStateKey,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 24,
                      alignment: WrapAlignment.center,
                      children: [
                        CFTextField(
                          controller: _cardNumber,
                          type: TextInputType.number,
                          hint: "0000 0000 0000 0000",
                          isNumberCard: true,
                          label: "Card Number",
                        ),
                        GetBuilder<CardController>(
                          id: "time",
                          init: CardController.instance,
                          builder: (controller) {
                            return GestureDetector(
                              onTap: () async {
                                final selected = await showMonthYearPicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2030));
                                controller.setTime = selected!;
                              },
                              child: CFTextField(
                                enabled: false,
                                controller: TextEditingController(
                                    text: controller.year == null && controller.month == null
                                        ? "": "${controller.year.toString()}-${controller.month.toString()}"),
                                hint: "MM/YY",
                                maxWidth: 170,
                                label: "Expiry Date",
                                formatterExtra: MaskTextInputFormatter(
                                    mask: '##/##', filter: {"#": RegExp(r'[0-9]')}
                                ),
                                suffixIcon: GestureDetector(

                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: ShowMedia(Images.menuBoard)),
                                ),
                                type: TextInputType.datetime,
                              ),
                            );
                          }
                        ),
                        CFTextField(
                          controller: _cvv,
                          hint: "00/00",
                          maxWidth: 170,
                          label: "CVC/CVV",
                          type: TextInputType.number,
                        ),
                        CFTextField(
                          controller: _nameCard,
                          type: TextInputType.text,
                          hint: "Name Card",
                          label: "Name on Card",
                        ),
                        SizedBox(
                          width: 343,
                          height: 50,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: ElevatedButton(onPressed:() {
                              CardController.instance.createCard(CardModel(id: null,
                                  cardNumber: _cardNumber.text.replaceAll(" ", ""),
                                  expiryDate: "${controller.year.toString()}-${controller.month.toString()}-01",
                                  cvv: _cvv.text,
                                  nameOnCard: _nameCard.text));
                            },
                                child: const Text("Register Card")),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
