import 'package:swish/contacts/data/model/contact_model.dart';
import '../../../core/errors/exeptions.dart';
import '../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/contact_repository.dart';
import '../dara_source/contact_remote_data_source.dart';


class ContactRepositoryImpl extends ContactRepository {

  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure,List<ContactModel>>> postCreateConcreteContact(
      {required List<String> list}) async {
    try {
      var res = await remoteDataSource.postConcreteContact(list);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

}