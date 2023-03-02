import 'package:swish/contacts/domain/entities/contact.dart';
import 'package:swish/user/domain/entities/profile.dart';


class ContactModel extends Contact {
  ContactModel(
      {required super.id,
        required super.profile,
        required super.userId,
      });



  @override
  bool operator == (Object other) =>
      identical(this, other) ||
          (other is Contact &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              profile == other.profile&&
              userId == other.userId);

  @override
  int get hashCode =>
      id.hashCode ^ profile.hashCode^ userId.hashCode;

  @override
  String toString() {
    return 'Contact{ id: $id,  profile: $profile,userId: $userId}';
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profile': profile,
      'userId' : userId,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
        id: map['id'] as int,
        profile: Profile(
            urlPic: map['avatar'],
            name: map['full_name'],
            email: map['email'],
            country: map['country'],
            address: map['address'],
            city: map['city'],
            postCode: map['post_code'],
            birthDate: DateTime.parse(map['birth_date']),
            phoneNumber: map['phone_number']),
        userId: map['user']['id'] as int);
  }

}

