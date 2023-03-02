import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:swish/core/service/local_storage.dart';
import 'package:swish/main.dart';
import 'package:swish/splash/presentation/pages/splash_screen.dart';
import 'package:swish/user/presentation/pages/profile_screen.dart';
import '../../../core/images/images.dart';
import '../../../core/utils/utils.dart';

enum PassType{set, verify, enter}

extension PassTypeEx on PassType {
 String get name {
   switch(this){
     case PassType.set: return "Set Password";
     case PassType.verify:return "Verify Password";
     case PassType.enter:return "Login Password";
   }
}
}

class PassScreen extends StatefulWidget {
  const PassScreen({Key? key, required this.type,
    this.verifyPass}) : super(key: key);
  final PassType type;
  final String? verifyPass;

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  final _formStateKey = GlobalKey<FormState>();

  String pass = "";

  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00012C),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image:
            AssetImage(Images.authBg.patch),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter)

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appBar(),
            _detailMainPage(context)
          ],
        ),
      ),

    );
  }

  toPage(BuildContext context, page){
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ));
  }

  setPass(BuildContext context){
    var storage = Get.find<LocalStorage>();
    if(pass.length<4) {
       error = "Password must be 4 digits";
       _formStateKey.currentState?.validate();
       return;
    }
    switch(widget.type){
      case PassType.set:{
        toPage(context, PassScreen(type: PassType.verify, verifyPass: pass));
      }
        break;
      case PassType.verify:{
       // go to setProfile
        storage.setPassword(pass);
       if(pass == widget.verifyPass) {
         Get.offAll(() =>const SplashPage());
       }else{
         error = "The entered password does not match the previous one";
         _formStateKey.currentState?.validate();
         return ;
       }
      }
        break;
      case PassType.enter:{
        var res = storage.checkPassword(pass);
        if(res)Get.offAll(() =>const MainPage());
        if(!res) {
            error = "The password is wrong";
            _formStateKey.currentState?.validate();
            return;
        }
        }
        break;
    }

  }

  _appBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 21)
          .add(EdgeInsets.only(top: sizeForMobileStatusBar)),
      child: Column(
        children: [
          ShowMedia(widget.type==PassType.enter?
          Images.logoPassScreen:Images.logo, width: 120),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  _detailMainPage(BuildContext context){
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.only(topLeft: Radius.circular(24),
              topRight: Radius.circular(24), )),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const Spacer(),
              Visibility(
                  visible: MediaQuery.of(context).viewInsets.bottom<=0,
                  child: const Center(child: ShowMedia(Images.key, width: 122,))),
              const Spacer(),
              Text(widget.type.name, style: const TextStyle(
                color: Color(0xff4F89EA),
                fontSize: 22
              ),),
              const Spacer(),
              Form(
                key: _formStateKey,
                child: PinInputTextFormField(
                  pinLength: 4,
                  keyboardType: TextInputType.number,
                  decoration: const UnderlineDecoration(colorBuilder:
                  FixedColorBuilder(Color(0xff4F89EA)),
                    hintText: "****"
                  ),
                  onChanged: (v)=> pass = v,
                  onSubmit: (v)=> setPass(context),
                  validator: (value) {
                    logger.d(error);
                    return error;
                  },

                ),
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
                         primary: const Color(0xff2260F5)),
                        onPressed: (){
                       setPass(context);
                    },
                        child: const Text("Continue")),
                  ),
                ),
              ),
              const Spacer(),
              if (widget.type==PassType.enter)GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("Forgot Password", style: TextStyle(
                      color: Color(0xff8B8B8B)
                    ),),
                    Icon(Icons.arrow_circle_right_outlined,
                      color: Color(0xff8B8B8B),),
                      ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}