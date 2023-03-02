import 'package:swish/core/utils/utils.dart';
import 'package:swish/wallet/domain/repositories/wallet_repository.dart';
import '../../../core/errors/exeptions.dart';
import '../data_source/wallet_remote_data_source.dart';


class WalletRepositoryImpl extends WalletRepository {

  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});


  @override
  void postMoneyTransfer({required Map<String,dynamic> map}) async {
    try {
      remoteDataSource.postMoneyTransfer(map);
    } on ServerException catch (e) {
      logger.e(e);
    }
  }

}