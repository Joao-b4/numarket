import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/entities/user.dart';
import '../../../utils/user_mock.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/users_repository_gql.dart';

class GraphQlAdapterMock extends Mock implements IGraphQlAdapter{}

void main() {
  final adapter = GraphQlAdapterMock();
  final repository = UsersRepositoryGraphQL(adapter);

  group('UsersRepository GraphQlImpl', () {
    test("should return an instance of user", () async{
      when(adapter.runQuery(any)).thenAnswer((_) async => ResultGetUserMockFromGraphqlMock);

      final result = await repository.getCurrentUser();

      expect(result, isA<Right>());
      expect(result.fold(id,id), isA<User>());
      User userResult = result.getOrElse(null);
      expect(userResult.id, userMock.id);
    });

    test("should return SyncUserAccountError if result is empty", () async{
      when(adapter.runQuery(any)).thenAnswer((_) async => {});
      final result = await repository.getCurrentUser();
      expect(result.fold(id,id), isA<SyncUserAccountError>());
    });

    test("should return SyncUserAccountError if result is exception", () async{
      when(adapter.runQuery(any)).thenThrow((_) async => Exception());
      final result = await repository.getCurrentUser();
      expect(result.fold(id,id), isA<SyncUserAccountError>());
    });
  });
}
