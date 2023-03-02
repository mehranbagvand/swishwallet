import 'package:dartz/dartz.dart';
import 'package:swish/card/data/model/card_model.dart';
import '../../../core/errors/failure.dart';
import '../entities/card.dart';

abstract class CardRepository {
  Future<Either<Failure, Card>> postConcreteCard({required CardModel cardModel});
  Future<Either<Failure,List<Card>>> getConcreteCard();
}
