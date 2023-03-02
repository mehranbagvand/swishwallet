part of app_enum;

enum CardType { visa, master }

extension CardIcon on CardType {
  Widget get bg {
    return ShowMedia(Images.card, color:
    this==CardType.visa?const Color(0xff9FE3BD):null,
      colorBlendMode: BlendMode.screen,
    );
  }

  Widget get icon {
    switch (this) {
      case CardType.visa:
        return const ShowMedia(Images.visa);
      case CardType.master:
        return const ShowMedia(Images.master);
    }
  }
}
