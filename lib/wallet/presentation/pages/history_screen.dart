import 'package:flutter/material.dart';
import 'package:swish/core/enums/app_enum.dart';
import 'package:swish/core/utils/utils.dart';
import 'package:swish/contacts/presentation/page/contact_screen.dart';
import 'package:swish/user/domain/entities/profile.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/images/images.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00012C),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.homeBg.patch),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_customAppBarHistory(context), _detailMainPage()],
        ),
      ),
    );
  }

  _customAppBarHistory(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: sizeForMobileStatusBar),
        const SizedBox(height: 12),
        const ShowMedia(Images.interestRate),
        const SizedBox(height: 20),
        Wrap(
          spacing: 38,
          children: [
            itemTile(
              icon: const ShowMedia(Images.upload),
              title: "Send",
              color: const Color(0xff9AB4F3),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(type: SendAsk.send),
                  )),
            ),
            itemTile(
                icon: const ShowMedia(Images.download),
                title: "Ask",
                color: const Color(0xffF98787),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(type: SendAsk.ask),
                  )),
            ),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }

  _detailMainPage() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(75))),
        child: Column(
          children: [
            _titlePage(),
           Expanded(
             child: SingleChildScrollView(
               child:_listHistoryPerson(),
             ),
           )
          ],
        ),
      ),
    );
  }

  _titlePage(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "History",
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: const [
                    Icon(
                      Icons.sort,
                      color: Color(0xffFC944D),
                      size: 15,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Clear all",
                      style: TextStyle(
                          color: Color(0xffFC944D), fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text("You have 324 histories",
              style: TextStyle(color: Color(0xff819099), fontSize: 16))
        ],
      ),
    );
  }

  itemTile(
      {required Widget icon, required String title,
        required Color color,required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Padding(padding: const EdgeInsets.all(15.0), child: icon),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
  
  
  _listHistoryPerson(){
    return Wrap(
      runSpacing: 24,
      spacing: 10,
      children: [
        itemHistoryPerson(
            Profile(
                id: 0,
                name: "Alex Mike",
                phoneNumber: "+4125123535",
                urlPic: Images.avatar1.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.decrease),
        itemHistoryPerson(
            Profile(
                id: 1,
                name: "Robert",
                phoneNumber: "+4125123535",
                urlPic: Images.avatar2.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.increase),
        itemHistoryPerson(
            Profile(
                id: 2,
                name: "Jenny",
                phoneNumber: "+4125523875",
                urlPic: Images.avatar3.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.decrease),
        itemHistoryPerson(
            Profile(
                id: 3,
                name: "Ahmed",
                phoneNumber: "+4158123935",
                urlPic: Images.avatar4.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.increase),
        itemHistoryPerson(
            Profile(
                id: 4,
                name: "Behnam Bagvand",
                phoneNumber: "+4147853535",
                urlPic: Images.avatar1.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.decrease),
        itemHistoryPerson(
            Profile(
                id: 3,
                name: "Ahmed",
                phoneNumber: "+4158123935",
                urlPic: Images.avatar2.patch,
                birthDate: DateTime.now(),
                city: '', email: '', address: '', postCode: '', country: ''),
            50,
            DateTime.now(),
            CountAction.decrease),
      ],
    );
  }

  itemHistoryPerson(Profile person, int count,
      DateTime dateTime, CountAction action){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          person.avatar(radius: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(person.name, style: const TextStyle(fontSize: 17),),
              const SizedBox(height: 8),
              Text(action==CountAction.increase?"SWISHED YOU ${count}MT":
              "YOU SWISHED ${count}MT", style: const TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w200, color: Color(0xff819099)),),
            ],
          ),
          const Spacer(),
          Text(timeago.format(dateTime, locale: 'en_short'), style: const TextStyle(
              color: Color(0xff819099), fontSize: 14),)
        ],
      ),
    );
  }
}



