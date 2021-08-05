import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/app/pages/home/home_page.dart';
import '../../utils/user_mock.dart';

class AppControllerMock extends Mock implements AppController {}

void main() {
  final appControllerMock = AppControllerMock();
  setUp((){
    initModule(AppModule());
  });

  testWidgets('HomePage load user', (tester) async {
//    when(appController.error).thenReturn(null);
//    when(appController.loading).thenReturn(false);
//    when(appController.user).thenReturn(userMock);
    await tester.runAsync(() async{
      await tester.pumpWidget(buildTestableWidget(HomePage()));
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }).then((value) {
      final titleFinder = find.text(userMock.name);
      expect(titleFinder, findsOneWidget);
    });
  });
}
