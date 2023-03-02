import 'package:swish/user/domain/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel(
      {required super.id,
      required super.name,
        required super.email, required super.country, required super.address,
        required super.city, required super.postCode, required super.birthDate,
      required super.phoneNumber,
      super.urlPic});



  static ProfileModel empty(){
    return ProfileModel(id: 0, name: "behnam", phoneNumber: "", urlPic: null,
        birthDate: DateTime.now(), city: '', address: '', postCode: '', email: '', country: '');
  }
  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          (other is Profile &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              email == other.email &&
              country == other.country &&
              address == other.address &&
              city == other.city &&
              postCode == other.postCode &&
              birthDate == other.birthDate &&
              urlPic == other.urlPic &&
              phoneNumber == other.phoneNumber);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      country.hashCode ^
      address.hashCode ^
      city.hashCode ^
      postCode.hashCode ^
      birthDate.hashCode ^
      urlPic.hashCode ^
      phoneNumber.hashCode;

  @override
  String toString() {
    return 'Profile{ id: $id, name: $name, email: $email, '
        'country: $country, address: $address, city: '
        '$city, postCode: $postCode, birthDate: $birthDate,'
        ' urlPic: $urlPic, phoneNumber: $phoneNumber,}';
  }

  ProfileModel copyWith({
    int? id,
    String? name,
    String? email,
    String? country,
    String? address,
    String? city,
    String? postCode,
    DateTime? birthDate,
    String? urlPic,
    String? phoneNumber,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      country: country ?? this.country,
      address: address ?? this.address,
      city: city ?? this.city,
      postCode: postCode ?? this.postCode,
      birthDate: birthDate ?? this.birthDate,
      urlPic: urlPic ?? this.urlPic,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': name,
      'email': email,
      'country': country,
      'address': address,
      'city': city,
      'post_code': postCode,
      'birth_date': birthDate.toIso8601String().split("T")[0],
      'avatar': urlPic,
    };
  }
  Map<String, dynamic> toMapEdit() {
    return {
      'full_name': name,
      'email': email,
      'country': country,
      'address': address,
      'city': city,
      'post_code': postCode,
      'birth_date': birthDate.toIso8601String().split("T")[0],
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int,
      name: map['full_name'] as String,
      email: map['email'] as String,
      country: map['country'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      postCode: map['post_code'] as String,
      birthDate: DateTime.parse(map['birth_date']),
      urlPic: map['avatar'] as String?,
      phoneNumber: (map['phoneNumber'] as String?)??"",
    );
  }

//</editor-fold>



}

