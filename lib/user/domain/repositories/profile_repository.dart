import 'package:dartz/dartz.dart';
import 'package:swish/user/data/models/person_model.dart';
import '../../../core/errors/failure.dart';
import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> editConcreteProfile({required ProfileModel profile});
  Future<Either<Failure, Profile>> postConcreteProfile({required ProfileModel profile});
  Future<Either<Failure, Profile>> getConcreteProfile();
  Future<Either<Failure, bool>> upConcreteAvatar({required int id,required body});
  Future<Either<Failure, bool>> deleteConcreteAvatar({required int id});
}
