import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/usecases/get_user.dart';
part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
   final IGetUser _usecaseGetUser;
  _AppControllerBase(this._usecaseGetUser){
    loadUser();
  }

  @observable
  User user;

  @computed
  bool get loading => user == null;

  @observable
  String error;

  @action
  loadUser() async {
    error = null;
    if(!(await DataConnectionChecker().hasConnection)){
      return error = "noConnection";
    }
    try{
      final result = await _usecaseGetUser();
      if (result.isRight()) {
        user = result.getOrElse(null);
      }else{
        error = "syncUserError";
      }
    }catch(e){
      error = "syncUserError";
    }
  }

}
