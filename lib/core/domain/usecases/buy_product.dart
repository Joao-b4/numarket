import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/domain/repositories/products_repository_interface.dart';

abstract class PurchaseResult{}

class PurchaseResultFailed implements PurchaseResult {
  final String message;

  PurchaseResultFailed(this.message);
}

class PurchaseResultSuccess implements PurchaseResult{
  final User customer;
  PurchaseResultSuccess(this.customer);
}

abstract class IBuyProduct{
  Future<Either<PurchaseResultFailed, PurchaseResultSuccess>> call(Product product);
}

class  BuyProduct implements IBuyProduct{
  final IProductsRepository repository;
  BuyProduct(this.repository);

  @override
  Future<Either<PurchaseResultFailed, PurchaseResultSuccess>> call(Product product) async {
    try{
      return repository.buy(product);
    } on PurchaseResultFailed catch (error) {
      return Left(error);
    }catch (error) {
      return Left(PurchaseResultFailed("500"));
    }
  }

}