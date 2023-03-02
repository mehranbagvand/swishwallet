import 'package:dartz/dartz.dart';
import 'package:swish/contacts/data/model/contact_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../core/usecases/use_case.dart';
import '../entities/contact.dart';
import '../repositories/contact_repository.dart';

class GetConcreteContact implements UseCaseType<List<Contact>, List<String>> {
  final ContactRepository repository;
  GetConcreteContact(this.repository);

  @override
  Future<Either<Failure,List<ContactModel>>> call(List<String> list) async {
    return await repository.postCreateConcreteContact(list: list);
  }
}
