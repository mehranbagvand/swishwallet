import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:swish/contacts/domain/repositories/contact_repository.dart';
import 'package:swish/user/domain/user_domain.dart';
import 'package:swish/user/data/profile_data.dart';
import 'package:swish/wallet/data/data_source/wallet_remote_data_source.dart';
import 'package:swish/wallet/data/repositorie/wallet_repository_impl.dart';
import 'package:swish/wallet/domain/repositories/wallet_repository.dart';
import 'package:swish/wallet/domain/use_cases/wallet_use_cases.dart';

import 'card/data/data_source/card_remote_data_source.dart';
import 'card/data/repositorie/card_repository_impl.dart';
import 'card/domain/repositories/card_repository.dart';
import 'card/domain/use_cases/card_use_cases.dart' as ad;
import 'contacts/data/dara_source/contact_remote_data_source.dart';
import 'contacts/data/repositorie/contact_repository_impl.dart';
import 'contacts/domain/use_cases/contact_use_cases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => GetConcreteProfile(sl()));
  sl.registerLazySingleton(() => ad.GetConcreteCard(sl()));
  sl.registerLazySingleton(() => ad.PostConcreteCard(sl()));
  sl.registerLazySingleton(() => PostConcreteProfile(sl()));
  sl.registerLazySingleton(() => EditConcreteProfile(sl()));
  sl.registerLazySingleton(() => DeleteConcreteAvatar(sl()));
  sl.registerLazySingleton(() => UpConcreteAvatar(sl()));
  sl.registerLazySingleton(() => GetConcreteContact(sl()));
  sl.registerLazySingleton(() => PostConcreteWallet(sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
          () => ProfileRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CardRepository>(
          () => CardRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ContactRepository>(
          () => ContactRepositoryImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<WalletRepository>(
          () => WalletRepositoryImpl(remoteDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
          () => ProfileRemoteDataSourceImpl(client: Get.find()));
  sl.registerLazySingleton<CardRemoteDataSource>(
          () => CardRemoteDataSourceImpl(client: Get.find()));
  sl.registerLazySingleton<ContactRemoteDataSource>(
          () => ContactRemoteDataSourceImpl(client: Get.find()));
  sl.registerLazySingleton<WalletRemoteDataSource>(
          () => WalletRemoteDataSourceImpl(client: Get.find()));

}