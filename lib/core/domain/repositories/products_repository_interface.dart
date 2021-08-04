import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';

abstract class IProductsRepository{
  Future<Either<PurchaseResultFailed, PurchaseResultSuccess>> buy(Product product){}
}