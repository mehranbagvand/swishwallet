library ui_utils;

import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:async/async.dart';
import '../../components/loading_indicator.dart';
part 'app_snack_bar.dart';
part 'app_dialog.dart';
part 'app_loading.dart';
part 'app_bottom_sheet.dart';

closeDialog() {
  if (Get.isDialogOpen ?? false||Get.isSnackbarOpen) Get.back();
}

bool isBig(BuildContext context) {
  Orientation big = MediaQuery.of(context).orientation;
  return Orientation.landscape == big;
}


