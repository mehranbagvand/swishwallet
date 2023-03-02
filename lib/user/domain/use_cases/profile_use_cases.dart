import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:swish/user/data/models/person_model.dart';
import 'package:swish/user/domain/user_domain.dart';
import '../../../../core/errors/failure.dart';
import '../../../core/usecases/use_case.dart';
import 'package:dio/dio.dart' as dio;

class GetConcreteProfile implements UseCase<Profile, NoParams> {
  final ProfileRepository repository;
  GetConcreteProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(NoParams params) async {
    return await repository.getConcreteProfile();
  }
}
class PostConcreteProfile implements UseCase<Profile, ProfileModel> {
  final ProfileRepository repository;

  PostConcreteProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(ProfileModel profile) async {
    return await repository.postConcreteProfile(profile: profile);
  }
}
class EditConcreteProfile implements UseCase<Profile, ProfileModel> {
  final ProfileRepository repository;

  EditConcreteProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(ProfileModel profile) async {
    return await repository.editConcreteProfile(profile: profile);
  }
}
class DeleteConcreteAvatar implements UseCase<bool, int> {
  final ProfileRepository repository;

  DeleteConcreteAvatar(this.repository);

  @override
  Future<Either<Failure, bool>> call(int id) async {
    return await repository.deleteConcreteAvatar(id: id);
  }
}
class UpConcreteAvatar implements UseCase<bool, AvatarParams> {
  final ProfileRepository repository;

  UpConcreteAvatar(this.repository);

  @override
  Future<Either<Failure, bool>> call(AvatarParams params) async {
    return await repository.upConcreteAvatar(id: params.id, body: params.data);
  }
}

class AvatarParams extends Equatable{
  final int id;
  final dio.FormData data;

  const AvatarParams(this.id, this.data);

  @override
  List<Object?> get props => [id, data];
}
