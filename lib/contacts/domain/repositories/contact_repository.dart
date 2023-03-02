import 'package:dartz/dartz.dart';
import 'package:swish/contacts/data/model/contact_model.dart';

import '../../../core/errors/failure.dart';

abstract class ContactRepository {
  Future<Either<Failure,List<ContactModel>>> postCreateConcreteContact({required List<String> list});
}