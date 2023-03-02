part of app_enum;

enum CountAction { increase, decrease }

extension ColorCountAction on CountAction {
  String get text => index==0?"+":"-";
  Widget get icon {
    switch (this) {
      case CountAction.increase:
        return const ShowMedia(Images.download);
      case CountAction.decrease:
        return const ShowMedia(Images.upload);
    }
  }

  Color get color {
    switch (this) {
      case CountAction.increase:
        return const Color(0xff9B51E0);
      case CountAction.decrease:
        return const Color(0xffD588C2);
    }
  }
}
