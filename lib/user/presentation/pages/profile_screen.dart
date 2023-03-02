import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:swish/core/images/images.dart';
import 'package:swish/core/utils/ui/ui_util.dart';
import 'package:swish/core/widgets/text_field_widget.dart';
import 'package:swish/user/data/models/person_model.dart';
import 'package:swish/user/presentation/manager/profile_controller.dart';
import '../../../core/utils/utils.dart';
import '../../domain/entities/profile.dart';
import 'edit_picture.dart';

enum ProfileType {edit , create, onlyRead}


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key, required this.type}) : super(key: key);
  final ProfileType type;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final controller = Get.put(ProfileController());

  final _formState = GlobalKey<FormState>();

  final cBirthDate = TextEditingController();

  @override
  void initState() {
    if(widget.type == ProfileType.edit){
      var p =controller.profile;
      controller.profileEdit = p.model;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const double fieldsSpace = 16;
    dynamic provider = controller.profile.urlPic != null &&
    controller.profile.urlPic != ""
        ? NetworkImage(convertToHttps(controller.profile.urlPic!))
        : AssetImage(Images.placeholder.patch);
    return Scaffold(
      floatingActionButton:widget.type==ProfileType.onlyRead?FloatingActionButton(
        onPressed: ()async{
         var res = await Get.to(()=>ProfileScreen(type: ProfileType.edit));
         if(res==true){
           controller.profile = await controller.getProfile();
           controller.storage.saveProfile(controller.profile);
           setState(() {});
         }
          },
        backgroundColor: const Color(0xffFBD56F),
      child: const Icon(Icons.edit,
        color: Color(0xffF2994A),),):null,
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: sizeForMobileStatusBar),
              width: double.infinity,
              height: 102,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.bgProfile.patch),
                      fit: BoxFit.fill)),
              child: Column(
                children:  [
                  const SizedBox(height: 44),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.0),
                    child: widget.type!=ProfileType.edit?const Text(
                      "Profile",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ):Row(
                      children: [
                        IconButton(onPressed: ()=>Get.back(),
                            icon: const Icon(Icons.arrow_back_sharp, color: Colors.white,)),
                        const Spacer(),
                        const Text(
                          "Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        IconButton(onPressed: (){},
                            icon: const Icon(Icons.arrow_back_sharp,
                              color: Colors.transparent,)),
                     ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Form(
                key: _formState,
                child:widget.type==ProfileType.onlyRead?_profile(isBig(context), context):
                _profileForm(context, controller.profile, fieldsSpace,
                          provider, isBig(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileForm(BuildContext context, Profile profile, double fieldsSpace,
      provider, [bool isBig = false]) {
    return SingleChildScrollView(
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: isBig ? 25 : 20,
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: EditPicture(
                  image: provider,
                  onChange: (v) => controller.changeAvatar(v),
                  imageBack: Images.placeholder.patch),
            ),
            CFTextFieldSimple(
              label: "Name & Surname:".tr,
              isRequired: true,
              initialValue: profile.name,
              textInputAction: TextInputAction.next,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(name: value),
              key: ValueKey("${profile.name}name"),
            ),

            CFTextFieldSimple(
              label: "Email".tr,
              isRequired: true,
              initialValue: profile.email,
              type: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(email: value),
              key: ValueKey("${profile.email}email"),
            ),
            CFTextFieldSimple(
              maxWidth: 175,
              label: "Country".tr,
              type: TextInputType.text,
              textInputAction: TextInputAction.next,
              isRequired: true,
              initialValue: profile.country,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(country: value),
              key: ValueKey("${profile.country}country"),
            ),
            CFTextFieldSimple(
              maxWidth: 175,
              label: "city".tr,
              type: TextInputType.text,
              textInputAction: TextInputAction.next,
              isRequired: true,
              initialValue: profile.city,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(city: value),
              key: ValueKey("${profile.city}city"),
            ),
            CFTextFieldSimple(
              label: "Address".tr,
              type: TextInputType.text,
              textInputAction: TextInputAction.next,
              isRequired: true,
              initialValue: profile.address,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(address: value),
              key: ValueKey("${profile.address}Address"),
            ),

            CFTextFieldSimple(
              maxWidth: 175,
              label: "Post Code".tr,
              type: TextInputType.number,
              textInputAction: TextInputAction.next,
              isRequired: true,
              maxLength: 10,
              initialValue: profile.postCode,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(postCode: value),
              key: ValueKey("${profile.postCode}postCode"),
            ),
            CFTextFieldSimple(
              maxWidth: 175,
              label: "Birth date".tr,
              textInputAction: TextInputAction.next,
              isRequired: true,
              controller: cBirthDate,
              readOnly: true,
              // initialValue: profile.postCode,
              onTextChange: (value) => controller.profileEdit =
                  controller.profileEdit.copyWith(birthDate:
                  (DateTime.tryParse(value)??DateTime.now())),
              key: ValueKey("${profile.birthDate}birthDate"),
              formatterExtra: MaskTextInputFormatter(
                  mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')}
              ),
              suffixIcon: GestureDetector(
                onTap: ()async{
                 var res=await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                  );
                if(res!=null) {
                  cBirthDate.text =
                    res.toString().split(" ").first;
                }
                },
                child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ShowMedia(Images.menuBoard)),
              ),
              type: TextInputType.datetime,
            ),
            Center(
              child: SizedBox(
                width: 343,
                height: 61,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0xff2260F5)),
                      onPressed: (){
                      onActionClick(context);
                      },
                      label: const Text("Continue")),
                ),
              ),
            ),
            const SizedBox(height: 5)
            // const SizedBox(width: double.infinity),
            // if (isBig)
            //   Center(
            //     child: CustoBu(
            //       "Save".tr,
            //       onClick: () => onActionClick(context),
            //       iconData: Icons.save,
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  Widget _profile(bool isBig, BuildContext context){
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: isBig ? 25 : 16,
            children: [
              controller.profile.avatar(radius: 50),
              _itemProfile("Name & Surname:", controller.profile.name),
              _itemProfile("Email:", controller.profile.email),
              _itemProfile("Country", controller.profile.country, width: 140),
              _itemProfile("City", controller.profile.city, width: 140),
              _itemProfile("Address", controller.profile.address),
              _itemProfile("Post Code", controller.profile.postCode,width: 140),
              _itemProfile("Birth Date", controller.profile.birthDate.toString()
                  .split(" ").first,width: 140),
            ],
          ),
        ),
      ),
    );
  }

  _itemProfile(String title, String subTitle, {double? width}){
   return SizedBox(
      height: 54,
      width:width?? 360,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title,
        style: const TextStyle(
          color: Color(0xff969696),
          fontSize: 16),
        ),
          const SizedBox(height: 16),
          Text(subTitle,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  onActionClick(BuildContext context) async {
    bool? isValid = _formState.currentState?.validate();
    if (isValid ?? false) {
      try {
        if(widget.type==ProfileType.create)return await AppLoading.loadingOn(() => controller.createProfile());
        if(widget.type==ProfileType.edit) await AppLoading.loadingOn(() => controller.editProfile());
          AppSnackBar.snackBar("Profile".tr, "Successfully saved".tr);
          Navigator.pop(context, true);
      } catch (e, s) {
        logger.e("Error in saving submitting profile", e, s);
      }
    }
  }
}

