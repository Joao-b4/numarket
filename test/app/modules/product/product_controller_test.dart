import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/modules/product/product_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';

class BuyProductMock extends Mock implements IBuyProduct {}

void main() {
  final usecase = BuyProductMock();
  ProductController productController = ProductController(usecase);

  group('AppController Test', () {
    test("First Test", () {
      expect(productController, isInstanceOf<ProductController>());
    });

  });
}
