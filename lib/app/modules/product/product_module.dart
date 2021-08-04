import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/app/modules/product/product_controller.dart';
import 'package:numarket/app/modules/product/product_page.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/products_repository_gql.dart';

class ProductModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => GraphQlAdapter()),
    Bind((i) => ProductsRepositoryGraphQL(i.get<GraphQlAdapter>())),
    Bind((i) => BuyProduct(i.get<ProductsRepositoryGraphQL>())),
    Bind((i) => ProductController(i.get<BuyProduct>())),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_,args) => ProductPage(id: args.data))
  ];

  static Inject get to => Inject<ProductModule>.of();
}
