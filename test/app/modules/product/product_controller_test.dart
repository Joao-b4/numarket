import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/modules/product/product_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/app/modules/product/product_module.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';

import '../../../utils/purchase_result_mock.dart';
import '../../../utils/user_mock.dart';

class BuyProductMock extends Mock implements IBuyProduct {}
class GetUserMock extends Mock implements IGetUser {}

void main() {
  final usecaseGetUser = GetUserMock();
  final usecaseBuyProduct = BuyProductMock();
  setUp(()async{
    initModule(AppModule(), changeBinds: [
      Bind<IGetUser>((i) => usecaseGetUser)
    ]);
    initModule(ProductModule(), changeBinds: [
      Bind<IBuyProduct>((i) => usecaseBuyProduct)
    ]);
    when(usecaseGetUser.call()).thenAnswer((_) async => dartz.Right(userMock));
    final AppController appController = AppModule.to.get<AppController>();
    await appController.loadUser();
  });

  group('ProductController Test', () {
    test("purchaseResult must should an instance of PurchaseResultSuccess", () async {
      when(usecaseBuyProduct.call(any)).thenAnswer((_) async => dartz.Right(purchaseResultSuccessMock));

      final ProductController controller = ProductModule.to.get<ProductController>();
      controller.loadOffer(productId: userMock.offers[0].id);
      await controller.buy();
      expect(controller.purchaseResult, purchaseResultSuccessMock);
    });

    test("purchaseResult must should an instance of PurchaseResultFailed", () async {
      when(usecaseBuyProduct.call(any)).thenAnswer((_) async => dartz.Left(purchaseResultFailedMock));
      final ProductController controller = ProductModule.to.get<ProductController>();
      controller.loadOffer(productId: userMock.offers[0].id);
      await controller.buy();
      expect(controller.purchaseResult, purchaseResultFailedMock);
    });

    test("error should not be null if productId is null", () async {
      final ProductController controller = ProductModule.to.get<ProductController>();
      controller.loadOffer(productId: null);
      expect(controller.error, isNot(equals(null)));
    });

    test("error should not be null if product Id does not exist", () async {
      final ProductController controller = ProductModule.to.get<ProductController>();
      controller.loadOffer(productId: 'xyz');
      expect(controller.error, isNot(equals(null)));
    });
  });
}


