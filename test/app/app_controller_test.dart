import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/errors/user_errors.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';
import '../utils/user_mock.dart';

class GetUserMock extends Mock implements IGetUser {}

void main() {
  final usecase = GetUserMock();
  setUp((){
    initModule(AppModule(), changeBinds: [
      Bind<IGetUser>((i) => usecase)
    ]);
  });

  group('AppController Test', () {
    test("should load instance of user", () async {
      when(usecase.call()).thenAnswer((_) async => dartz.Right(userMock));
      final AppController controller = Modular.get();
      await controller.loadUser();
      expect(controller.user.id, userMock.id);
    });

    test("error should not be null if usecase return SyncUserAccountError", () async {
      when(usecase.call()).thenAnswer((_) async => dartz.Left(SyncUserAccountError()));
      final AppController controller = Modular.get();
      await controller.loadUser();
      expect(controller.error, isNot(equals(null)));
    });

    test("error should not be null if usecase failed", () async {
      when(usecase.call()).thenThrow((_) async => Exception());
      final AppController controller = Modular.get();
      await controller.loadUser();
      expect(controller.error, isNot(equals(null)));
    });
  });
}
