import 'package:swish/user/domain/entities/profile.dart';

class Contact {
  final int  id;
  final Profile profile;
  final int userId;


  const Contact(
      {
        required this.userId,
        required this.id, required this.profile,
      });
}