import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListPlaceholderView extends StatelessWidget {
  const ListPlaceholderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Shimmer.fromColors(
        baseColor: const Color(0xffefefef),
        highlightColor: const Color(0xfff8f8f8),
        child: ListTile(
          leading: Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const CircleAvatar(
              radius: 25,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(right: 130),
            child: Container(
              height: 9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 170),
            child: Container(
              height: 9,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
            ),
          ),
        ),
      ),
    );
  }
}
