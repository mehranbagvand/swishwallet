library images;

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:video_player/video_player.dart';
import '../enums/app_enum.dart';

part 'widgets/backdrop_blur.dart';
part 'widgets/show_image.dart';


class MediaAssets{
  final String suffix;
  final AssetEnum asset;
  final TypeFileEnum type;

  const MediaAssets(this.suffix, {required this.asset, required  this.type});
  String get patch => "${asset.patch}$suffix.${type.name}";
  AssetImage get assetImage => AssetImage(patch);
}

class Images {
  Images._();

  static const MediaAssets bg = MediaAssets("bg",
      asset: AssetEnum.pictures, type: TypeFileEnum.jpg);
  static const MediaAssets bgInitPage = MediaAssets("bgInitPage",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets bgLogin = MediaAssets("bLogin",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets otpPic = MediaAssets("otpPic",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets bgProfile = MediaAssets("bgProfile",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets avatar1 = MediaAssets("avatar1",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets avatar2 = MediaAssets("avatar2",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets avatar3 = MediaAssets("avatar3",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets avatar4 = MediaAssets("avatar4",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets authBg = MediaAssets("authBg",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets numberAuth = MediaAssets("numberAuth",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets bgSplash = MediaAssets("bgSplash",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets placeholder = MediaAssets("placeholder",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets bgStatus = MediaAssets("bgStatus",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets buyToken = MediaAssets("buyToken",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);
  static const MediaAssets cashOut = MediaAssets("cashOut",
      asset: AssetEnum.pictures, type: TypeFileEnum.png);


  // ions
  static const MediaAssets whatsapp = MediaAssets("whatsapp",
      asset: AssetEnum.icons, type: TypeFileEnum.png);
  static const MediaAssets profit = MediaAssets("profit",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets bank = MediaAssets("bank",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets visa = MediaAssets("visa",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets master = MediaAssets("master",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets download = MediaAssets("download",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets upload = MediaAssets("upload",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets swish = MediaAssets("swish",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets person = MediaAssets("user",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets menuBoard = MediaAssets("menu-board",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets search = MediaAssets("search",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets closeSquare = MediaAssets("closeSquare",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets addSquare = MediaAssets("addSquare",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets logo = MediaAssets("logo",
      asset: AssetEnum.icons, type: TypeFileEnum.svg);
  static const MediaAssets logoPassScreen = MediaAssets("logoPassScreen",
      asset: AssetEnum.icons, type: TypeFileEnum.png);

  // vectors
  static const MediaAssets homeBg = MediaAssets("homeBg",
      asset: AssetEnum.vectors, type: TypeFileEnum.png);
  static const MediaAssets bankMoney = MediaAssets("bl",
      asset: AssetEnum.vectors, type: TypeFileEnum.png);
  static const MediaAssets bgMoney = MediaAssets("bgMoney",
      asset: AssetEnum.vectors, type: TypeFileEnum.png);
  static const MediaAssets card = MediaAssets("card",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);
  static const MediaAssets interestRate = MediaAssets("InterestRate",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);
  static const MediaAssets abr = MediaAssets("abr",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);
  static const MediaAssets art = MediaAssets("art",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);
  static const MediaAssets phone = MediaAssets("phone",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);

  static const MediaAssets cardImg = MediaAssets("cardImg",
      asset: AssetEnum.vectors, type: TypeFileEnum.png);
  static const MediaAssets numberOTP = MediaAssets("numberOTP",
      asset: AssetEnum.vectors, type: TypeFileEnum.png);
  static const MediaAssets key = MediaAssets("key",
      asset: AssetEnum.vectors, type: TypeFileEnum.svg);
}
class Videos {
  Videos._();
  static const MediaAssets screen = MediaAssets("screen",
      asset: AssetEnum.videos, type: TypeFileEnum.webm);
}