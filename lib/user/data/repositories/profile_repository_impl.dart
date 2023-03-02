import 'package:swish/user/data/models/person_model.dart';
import 'package:swish/user/domain/user_domain.dart';
import '../../../core/errors/exeptions.dart';
import '../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {

  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Profile>> getConcreteProfile() async {
    try {
      var res = await remoteDataSource.getConcreteProfile();
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, Profile>> postConcreteProfile(
      {required ProfileModel profile}) async {
    try {
      var res = await remoteDataSource.postConcreteProfile(profile);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, Profile>> editConcreteProfile(
      {required ProfileModel profile}) async {
    try {
      var res = await remoteDataSource.editConcreteProfile(
          profile);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteConcreteAvatar({required int id}) async{
    try {
      var res = await remoteDataSource.deleteConcreteAvatar(id);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }

  @override
  Future<Either<Failure, bool>> upConcreteAvatar({required int id, body}) async{
    try {
      var res = await remoteDataSource.upConcreteAvatar(id,body);
      return Right(res);
    } on ServerException {
      return const Left(ServerFailure("server"));
    }
  }
}