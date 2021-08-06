import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/products_repository_gql.dart';

import '../../../utils/purchase_result_mock.dart';

class GraphQlAdapterMock extends Mock implements IGraphQlAdapter {}

void main() {
  final adapter = GraphQlAdapterMock();
  final repository = ProductsRepositoryGraphQL(adapter);

  group('ProductsRepository GraphQlImpl', () {
    test("should return PurchaseResultSuccess if purchase is successful", () async {
      when(adapter.runMutation(any)).thenAnswer((_) async => PurchaseResultSuccessFromGraphqlMock);
      final product = Product(offerId: "offer/portal-gun");
      final result = await repository.buy(product);
      expect(result, isA<Right>());
      PurchaseResultSuccess purchaseResult = result.getOrElse(null);
      expect(purchaseResult.customer.balance, purchaseResultSuccessMock.customer.balance);
    });

    test("should return PurchaseResultFailed if product is null", () async{
      final result = await repository.buy(null);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

    test("should return PurchaseResultFailed if result is failed", () async{
      when(adapter.runMutation(any)).thenAnswer((_) async => PurchaseResultFailedFromGraphqlMock);
      final product = Product();
      final result = await repository.buy(product);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

    test("should return PurchaseResultFailed if result is exception", () async{
      when(adapter.runMutation(any)).thenThrow((_) async => Exception());
      final product = Product();
      final result = await repository.buy(product);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

  });
}
