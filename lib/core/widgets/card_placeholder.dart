import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardPlaceholderView extends StatelessWidget {
  const CardPlaceholderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var decoration = BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(10));
    return Container(
      decoration:  BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      margin: const EdgeInsetsDirectional.only(start: 11),
      padding: const EdgeInsetsDirectional.only(top:5),
      child: Shimmer.fromColors(
        baseColor: const Color(0xffefefef),
        highlightColor: const Color(0xfff8f8f8),
        child: Container(
          width: 209,
          height: 95,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 35,
                    decoration: decoration,
                  ),
                  const Spacer(),
                  Container(
                    width: 70,
                    height: 15,
                    decoration: decoration,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    width: 90,
                    height: 15,
                    decoration: decoration,
                  ),
                  const Spacer(),
                  Container(
                    width: 30,
                    height: 15,
                    decoration: decoration,

                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
