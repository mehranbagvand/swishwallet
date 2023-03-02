
import '../../../core/usecases/use_case.dart';
import '../repositories/wallet_repository.dart';

class PostConcreteWallet implements UseCaseTypeVoid<NoParams, Map<String,double>> {
  final WalletRepository repository;
  PostConcreteWallet(this.repository);

  @override
  void call(Map<String,dynamic> map) async {
    return repository.postMoneyTransfer(map: map);
  }
}