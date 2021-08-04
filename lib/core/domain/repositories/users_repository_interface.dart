import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';

abstract class IUsersRepository{
  Future<Either<SyncUserAccountError, User>> getCurrentUser(){}
}