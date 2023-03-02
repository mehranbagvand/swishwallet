import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/contacts/presentation/manager/contact_controller.dart';
import 'package:swish/core/enums/app_enum.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/core/widgets/text_field_widget.dart';

import '../../../core/widgets/list_placeholder.dart';
import '../../../wallet/presentation/pages/transfer_screen.dart';
import '../../data/model/contact_model.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required this.type}) : super(key: key);
  final SendAsk type;

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  @override
  void initState() {
    ContactController.instance.askPermissions();
    super.initState();
  }

  var searchText = "";
  List<ContactModel> _personSearch = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body:GetBuilder<ContactController>(
          id: "contact",
        builder: (controller) {
          return Column(
            children: [
              const SizedBox(height: 6),
              _searchWidget(controller),
              _listPresentPerson(controller),
              Expanded(child: _contentData(controller))
            ],
          );
        }
      ),
    );
  }

  _searchWidget(ContactController controller) {
    _personSearch = ContactController.instance.contactItem == null ? []: ContactController.instance.contactItem!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: CFTextField(
        autofocus: false,
        hint: "Search in contents",
        onTextChange: (v) => {
          setState(() => searchText = v),
         _personSearch = controller.contactItem!.where((element) =>
        element.profile.name.contains(v)).toList()
        },
        fillColor: const Color(0xffFAFAFA),
        enabledBorderColor: const Color(0xffFAFAFA),
        focusedBorderColor: const Color(0xffFAFAFA),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(10.0),
          child: ShowMedia(Images.search),
        ),
        suffixIcon: Visibility(
          visible: searchText != "",
          child: GestureDetector(
            onTap: (){
              searchText = "";
              _personSearch = controller.contactItem!;
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: ShowMedia(Images.closeSquare),
            ),
          ),
        ),
      ),
    );
  }

  _listPresentPerson(ContactController controller){
    return Builder(
      builder: (context) {
        if(controller.contactItem == null){
          return Container();
        }
        if(controller.contactItem!.isEmpty){
          return const Center(child: Text("list is empty",
            style: TextStyle(color: Colors.black),),);
        }
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Recent", style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16),),
              Container(
                height: 84,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                    itemCount: controller.contactItem!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int index) {
                      return _itemPresentPerson(controller.contactItem![index]);
                    }, separatorBuilder: (BuildContext
                context, int index) => const SizedBox(width: 24)),
              ),
            ],
          ),
        );
      }
    );
  }

  _itemPresentPerson(ContactModel person){
    var names = person.profile.name.split(" ");
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransferScreen(
                userId: person.userId,
                type: widget.type, profile: person.profile),
          )),
      child: Column(
        children: [
          person.profile.avatar(),
          const SizedBox(height:6),
          Text(names.length !=1 ? names[0] : person.profile.name,
              style: const TextStyle(color: Color(0xff666666)))
        ],
      ),
    );
  }

  _contentData(ContactController controller){
    var title = searchText==""?"Search for $searchText":"All Content";
    return Builder(
      builder: (context) {
        if(controller.contactItem == null){
          return  ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const ListPlaceholderView();
            },
          );
        }
        if(controller.contactItem!.isEmpty){
          return const Center(child: Text("list is empty",
            style: TextStyle(color: Colors.black),),);
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23.0),
              child: Text(title, style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    itemCount: controller.contactItem!.length,
                    itemBuilder: (BuildContext context,int index) {
                      return _itemContent(controller.contactItem![index]);
                    }, separatorBuilder: (BuildContext
                context, int index) => const SizedBox(height: 16)),
              ),
            ),

          ],
        );
      }
    );
  }

  _itemContent(ContactModel person) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransferScreen(
              userId: person.userId,
                type: widget.type, profile: person.profile),
          )),
      child: Row(
        children: [
          person.profile.avatar()
          ,
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(person.profile.name, style: const TextStyle(
                  color: Color(0xff333333), fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(person.profile.phoneNumber,
                  style: const TextStyle(color:
                  Color(0xff8B8B8B), fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      centerTitle: true,
      title: Text("${widget.type.name} Token",
        style: const TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold),),
      actions: const [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ShowMedia(Images.addSquare),
          ),
        )
      ],

      elevation: 0,
    );
  }
}
