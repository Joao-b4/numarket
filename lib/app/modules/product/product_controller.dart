import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
part 'product_controller.g.dart';

@Injectable()
class ProductController = _ProductControllerBase with _$ProductController;

abstract class _ProductControllerBase with Store {
  final IBuyProduct _usecaseBuyProduct;
  _ProductControllerBase(this._usecaseBuyProduct);

  @observable
  User _customer;

  @observable
  String productId;

  @computed
  Product get product  {
    if(_customer != null && productId != null){
      return _customer.offers.firstWhere((product) => product.id == productId);
    }
  }

  @computed
  bool get loading => product == null;

  @observable
  PurchaseResult purchaseResult;

  @observable
  bool purchaseProcess = false;

  AppController _appController;

  @action
  loadOffer({String productId}){
    _appController = AppModule.to.get<AppController>();
    this._customer = _appController.user;
    this.productId = productId;
  }

  @action
  buy() async{
    purchaseProcess = true;
    if(!(await DataConnectionChecker().hasConnection)){
       purchaseResult = PurchaseResultFailed('Sem Conexão');
      purchaseProcess = false;
       return;
    }
    final result = await _usecaseBuyProduct(product);
    result.fold((PurchaseResultFailed failed){
      purchaseResult = failed;
    }, (PurchaseResultSuccess success) {
      purchaseResult = success;
      _customer = success.customer;
      _appController.user = success.customer;
    });
    purchaseProcess = false;
  }
}

