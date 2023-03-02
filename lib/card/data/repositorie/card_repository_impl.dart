import 'package:swish/card/data/model/card_model.dart';
import 'package:swish/card/domain/repositories/card_repository.dart';
import '../../../core/errors/exeptions.dart';
import '../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/card.dart';
import '../data_source/card_remote_data_source.dart';


class CardRepositoryImpl extends CardRepository {

  final CardRemoteDataSource remoteDataSource;

  CardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure,List<Card>>> getConcreteCard() async {
    try {
      var res = await remoteDataSource.getConcreteCard();
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, Card>> postConcreteCard(
      {required CardModel cardModel}) async {
    try {
      var res = await remoteDataSource.postConcreteCard(cardModel);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

}