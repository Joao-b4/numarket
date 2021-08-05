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
      when(adapter.runQuery(any)).thenAnswer((_) async => ResultGetUserMock);

      final result = await repository.getCurrentUser();

      expect(result, isA<Right>());
      User userResult = result.getOrElse(null);
      expect(userResult.id, userMock.id);
    });

    test("should return an SyncUserAccountError if result is not CustomerModel", () async{
      when(adapter.runQuery(any)).thenAnswer((_) async => {});
      final result = await repository.getCurrentUser();
      expect(result.fold(id,id), isA<SyncUserAccountError>());
    });
  });
}
