import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/app/app_widget.dart';
import 'package:numarket/app/modules/product/product_module.dart';
import 'package:numarket/app/pages/home/home_page.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';
import 'package:numarket/core/infra/adapters/graphql_adapter.dart';
import 'package:numarket/core/infra/repositories/users_repository_gql.dart';
import 'app_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => GraphQlAdapter()),
        Bind((i) => UsersRepositoryGraphQL(i.get<GraphQlAdapter>())),
        Bind((i) => GetUser(i.get<UsersRepositoryGraphQL>())),
        Bind((i) => AppController(i.get<GetUser>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/product', module: ProductModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
