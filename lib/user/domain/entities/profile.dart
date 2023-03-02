

import 'package:flutter/material.dart';
import 'package:swish/core/images/images.dart';

import '../../data/models/person_model.dart';

class Profile {
  final int? id;
  final String name;
  final String email;
  final String country;
  final String address;
  final String city;
  final String postCode;
  final DateTime birthDate;
  final String? urlPic;
  final String phoneNumber;

  const Profile({
    this.id,
    required this.name,
    this.urlPic,
    required this.email, required this.country, required this.address,
    required this.city, required this.postCode, required this.birthDate,
    required this.phoneNumber,
  });


  Widget avatar ({double radius = 29,bool notCircle = false}){
    dynamic provider = urlPic == null?
    AssetImage(Images.placeholder.patch):urlPic!.
    contains("http")?NetworkImage(avatarUrl):AssetImage(urlPic!);
    if(notCircle) {
      return Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          image: DecorationImage(image: provider)
        ),
      );
    }
    return CircleAvatar(
        radius: radius,
        backgroundImage: provider);
  }

  String get avatarUrl{
    return urlPic!.replaceAll("http", "https");
  }

  ProfileModel get model {
    return ProfileModel(id: id, name: name, email: email,
        country: country, address: address, city: city, urlPic: urlPic,
        postCode: postCode, birthDate: birthDate, phoneNumber: phoneNumber);
  }


}