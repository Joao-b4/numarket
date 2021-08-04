import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/modules/product/product_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';

class GetUserMock extends Mock implements IGetUser {}

void main() {
  final usecase = GetUserMock();
  AppController appController = AppController(usecase);

  group('AppController Test', () {
    test("First Test", () {
      expect(appController, isInstanceOf<AppController>());
    });

    test("should return an instance of user", () async {
      when(usecase.call()).thenAnswer((_) async => Right(User()));
      expect(appController.user, isA<User>());
    });
  });
}
