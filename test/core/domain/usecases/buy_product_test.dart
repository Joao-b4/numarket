import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/repositories/products_repository_interface.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import '../../../utils/purchase_result_mock.dart';

class ProductsRepositoryMock extends Mock implements IProductsRepository{}

void main() {
  final repository = ProductsRepositoryMock();
  final usecase = BuyProduct(repository);

  group('BuyProduct usecase', () {
    test("should return an instance of PurchaseResultSuccess", () async{
      Product product = new Product();
      when(repository.buy(product)).thenAnswer((_) async => Right(purchaseResultSuccessMock));

      final result = await usecase(product);

      expect(result.isRight(), true);
      expect(result.getOrElse(null), equals(purchaseResultSuccessMock));
    });

    test("should return an instance of PurchaseResultFailed", () async{
      Product product = new Product();
      when(repository.buy(product)).thenAnswer((_) async => Left(purchaseResultFailedMock));

      final result = await usecase(product);

      expect(result.isLeft(), true);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

    test("should return PurchaseResultFailed if repository failed", ()async {
      Product product = new Product();
      when(repository.buy(product)).thenThrow((_) async => Exception());

      final result = await usecase(product);

      expect(result.isLeft(), true);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

  });
}
