import 'package:dartz/dartz.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/repositories/products_repository_interface.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/models/customer_model.dart';

class ProductsRepositoryGraphQL implements IProductsRepository {
  final IGraphQlAdapter client;
  ProductsRepositoryGraphQL(this.client);

  @override
  Future<Either<PurchaseResultFailed, PurchaseResultSuccess>> buy(
      Product product) async {
    try {
      if(product == null){
        return Left(PurchaseResultFailed("product is null"));
      }
      var document = 'mutation{ purchase(offerId:"${product.offerId}"){ success errorMessage customer{name id offers{id price product{ id name description image}} balance}}}';
      Map response = await client.runMutation(document);
      Map purchase = response['purchase'];
      if(purchase['success']){
        return Right(PurchaseResultSuccess(CustomerModel.fromMap(purchase['customer'])));
      }
      if(purchase['errorMessage'] != null){
        return Left(PurchaseResultFailed(purchase['errorMessage']));
      }
    } catch (e) {
      return Left(PurchaseResultFailed(e.toString()));
    }
  }
}
