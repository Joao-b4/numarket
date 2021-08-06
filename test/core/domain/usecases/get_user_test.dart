import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/domain/repositories/users_repository_interface.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';
import '../../../utils/user_mock.dart';

class UsersRepositoryMock extends Mock implements IUsersRepository{}

void main() {
  final repository = UsersRepositoryMock();
  final usecase = GetUser(repository);

  group('GetUser usecase', () {
    test("should return an instance of user", () async{
      when(repository.getCurrentUser()).thenAnswer((_) async => Right(userMock));

      final result = await usecase();

      expect(result, isA<Right>());
      expect(result.getOrElse(null), equals(userMock));
    });

    test("should return an instance of SyncUserAccountError", () async{
      when(repository.getCurrentUser()).thenAnswer((_) async => Left(SyncUserAccountError()));

      final result = await usecase();

      expect(result.isLeft(), true);
      expect(result.fold(id,id), isA<SyncUserAccountError>());
    });

    test("should return SyncUserAccountError if repository failed", ()async {
      when(repository.getCurrentUser()).thenThrow((_) async => Exception());

      final result = await usecase();

      expect(result.isLeft(), true);
      expect(result.fold(id,id), isA<SyncUserAccountError>());
    });

  });
}
