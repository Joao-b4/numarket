import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/domain/repositories/users_repository_interface.dart';

abstract class IGetUser{
  Future<Either<SyncUserAccountError, User>> call();
}

class  GetUser implements IGetUser{
  final IUsersRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<SyncUserAccountError, User>> call() async {
    try {
      return repository.getCurrentUser();
    } on SyncUserAccountError catch (error) {
      return Left(error);
    }catch (error) {
      return Left(SyncUserAccountError());
    }
  }
}