part of ui_utils;


/// contains all snackBar templates
class AppSnackBar {
  static snackBar(String title, String msg, {bool? noCloseDialog, bool? back}) async {
    if (noCloseDialog == null) closeDialog();
    if(back!=null&&back)Get.back();
    Get.snackbar(title, msg);
  }
  static snackBarE4xx(String title, String msg, {bool? noCloseDialog, bool? back}) async {
    if (noCloseDialog == null) closeDialog();
    if(back!=null&&back)Get.back();
    Get.snackbar(title, msg, backgroundColor: Colors.red,
        icon: const Icon(Icons.house_rounded),
    animationDuration: 2.seconds);
  }
  static snackBarE5xx(String title, String msg, {bool? noCloseDialog, bool? back}) async {
    if (noCloseDialog == null) closeDialog();
    if(back!=null&&back)Get.back();
    Get.snackbar(title, msg, backgroundColor: Colors.pink,
       icon: const Icon(Icons.miscellaneous_services_sharp),
        animationDuration: 2.seconds);
  }

  static successfulSnackBar() {
    snackBar("Successful".tr, "Successfully saved".tr);
  }

}
