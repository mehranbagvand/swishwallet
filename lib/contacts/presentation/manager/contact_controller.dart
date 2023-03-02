import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:swish/contacts/data/model/contact_model.dart';
import 'package:swish/core/utils/utils.dart';



import 'package:permission_handler/permission_handler.dart';

import '../../../injection_container.dart';
import '../../domain/use_cases/contact_use_cases.dart';

class ContactController extends GetxController{
  static ContactController get instance => Get.isRegistered<ContactController>()
      ? Get.find<ContactController>() : Get.put(ContactController());

  List<Contact>? _contactLists;
  List<Contact>? get contacts => _contactLists;
  final GetConcreteContact  _postConcreteContact = sl();

  List<ContactModel>? contactItem;

  Future postContacts(List<String> listContact) async {
    try{
      var res = await _postConcreteContact(listContact);
      contactItem = res.toIterable().first;
    }on Exception catch (e){
      logger.e(e);
    }
    update(['contact']);
  }





  void getContacts() async {
    _contactLists = await ContactsService.getContacts(withThumbnails: false);
    logger.d(_contactLists?.map((e) => e.phones!.first.value));
     await postContacts((_contactLists!.map((e) => e.phones?.first.value!.replaceFirst("0", "+98").replaceAll(" ", "") ?? "").toList()));
  }


  Future<void> askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) async{
    if (permissionStatus == PermissionStatus.denied) {
      Get.back();
      Get.snackbar("OPS!", "Do not allow access to contacts. You cannot use this section");
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      Get.back();
      Get.snackbar("OPS!", "Please give access to the contacts");
      await openAppSettings();
    }
  }



}