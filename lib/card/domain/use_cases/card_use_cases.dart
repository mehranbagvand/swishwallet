import 'package:dartz/dartz.dart';
import 'package:swish/card/data/model/card_model.dart';
import '../../../../core/errors/failure.dart';
import '../../../core/usecases/use_case.dart';

import '../entities/card.dart';
import '../repositories/card_repository.dart';

class GetConcreteCard implements UseCase<List<Card>, NoParams> {
  final CardRepository repository;
  GetConcreteCard(this.repository);

  @override
  Future<Either<Failure,List<Card>>> call(NoParams params) async {
    return await repository.getConcreteCard();
  }
}
class PostConcreteCard implements UseCase<Card, CardModel> {
  final CardRepository repository;

  PostConcreteCard(this.repository);

  @override
  Future<Either<Failure, Card>> call(CardModel cardModel) async {
    return await repository.postConcreteCard(cardModel: cardModel);
  }
}
