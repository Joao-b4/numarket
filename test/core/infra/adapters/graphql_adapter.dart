import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';

class GraphQLClientMock extends Mock implements GraphQLClient{}
class GraphQLExceptiontMock extends Mock implements OperationException{}

void main() {
  final adapter = GraphQlAdapter();
  final gqlMock = GraphQLClientMock();
  adapter.client = gqlMock;

  group('GraphQL Adapter', () {
    test("should return an instance of IGraphQLAdapter", () async{
      expect(adapter, isA<IGraphQlAdapter>());
    });

    test("should return Map if runQuery is successful", ()async {
      when(gqlMock.query(any)).thenAnswer((_) async=> QueryResult(data: {}));
      final result = await adapter.runQuery("");
      expect(result,isA<Map>());
    });

    test("should return Exception if runQuery is failed", ()async {
      when(gqlMock.query(any)).thenAnswer((_) async=> QueryResult(exception: GraphQLExceptiontMock()));
      final futureResult = adapter.runQuery("");
      expect(futureResult, throwsA(isA<Exception>()));
    });

    test("should return Map if runMutation is successful", ()async {
      when(gqlMock.mutate(any)).thenAnswer((_) async=> QueryResult(data: {}));
      final result = await adapter.runMutation("");
      expect(result,isA<Map>());
    });

    test("should return Exception if runMutation is failed", ()async {
      when(gqlMock.mutate(any)).thenAnswer((_) async=> QueryResult(exception: GraphQLExceptiontMock()));
      final futureResult = adapter.runMutation("");
      expect(futureResult, throwsA(isA<Exception>()));
    });

    test("should return Map if runQuery in nubank end-point is successful", ()async {
      const document = r'''
        {
          __schema {
            types{name}
          }
        }
      ''';
      adapter.connect();
      final result = await adapter.runQuery(document);
      expect(result,isA<Map>());
    });

  });
}
