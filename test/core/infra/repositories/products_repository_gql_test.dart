import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/products_repository_gql.dart';

class GraphQlAdapterMock extends Mock implements IGraphQlAdapter {}

const resultPurchaseFailedMock = {
  "purchase": {
    "success": false,
    "errorMessage": "You don't have that much money.",
    "customer": {
      "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      "name": "Jerry Smith",
      "balance": 1000000
    }
  }
};
const resultPurchaseSuccessMock = {
  "purchase": {
    "success": true,
    "errorMessage": null,
    "customer": {
      "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      "name": "Jerry Smith",
      "balance": 995000
    }
  }
};

void main() {
  final adapter = GraphQlAdapterMock();
  final repository = ProductsRepositoryGraphQL(adapter);

  group('ProductsRepository GraphQlImpl', () {
    test("should return an PurchaseResultSuccess if purchase is successful", () async {
      when(adapter.runMutation(any)).thenAnswer((_) async => resultPurchaseSuccessMock);
      final product = Product(offerId: "offer/portal-gun");
      final result = await repository.buy(product);
      expect(result, isA<Right>());
      expect(result | null, isA<PurchaseResultSuccess>());
    });

    test("should return an PurchaseResultFailed if result is failed", () async{
      when(adapter.runMutation(any)).thenAnswer((_) async => resultPurchaseFailedMock);
      final product = Product();
      final result = await repository.buy(product);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });


    test("should return an PurchaseResultFailed if product is null", () async{
      when(adapter.runMutation(any)).thenAnswer((_) async => resultPurchaseFailedMock);
      final result = await repository.buy(null);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

  });
}
