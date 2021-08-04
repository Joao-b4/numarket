import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/repositories/products_repository_interface.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';

class ProductsRepositoryMock extends Mock implements IProductsRepository{}

void main() {
  final repository = ProductsRepositoryMock();
  final usecase = BuyProduct(repository);

  group('BuyProduct usecase', () {
    test("should return an instance of PurchaseResultSuccess", () async{
      Product product = new Product();
      when(repository.buy(product)).thenAnswer((_) async => Right(PurchaseResultSuccess(User())));

      final result = await usecase(product);

      expect(result.isRight(), true);
      expect(result | null, isA<PurchaseResultSuccess>());
    });

    test("should return PurchaseResultFailed if repository fails", ()async {
      Product product = new Product();
      when(repository.buy(product)).thenThrow((_) async => Exception);

      final result = await usecase(product);

      expect(result.isLeft(), true);
      expect(result.fold(id,id), isA<PurchaseResultFailed>());
    });

  });
}
