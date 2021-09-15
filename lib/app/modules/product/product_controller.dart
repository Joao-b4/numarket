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
  User customer;

  @observable
  Product product;

  @computed
  bool get loading => product == null;

  @observable
  PurchaseResult purchaseResult;

  @observable
  bool purchaseProcess = false;

  AppController _appController;

  @observable
  String error;

  @action
  loadOffer({String productId}) {
    error = null;
    try{
      if(productId == null || productId.isEmpty){
        return error = "productIdNotInformed";
      }
      _appController = AppModule.to.get<AppController>();
      customer = _appController.user;
      if (customer != null && productId != null) {
        Product productFound = customer.offers.firstWhere((product) => product.id == productId);
        if(productFound != null){
          product = productFound;
        }else{
          error = "productNotFound";
        }
      }
    }catch(e){
      error = "errorToLoadProduct";
    }
  }

  @action
  buy() async {
    purchaseProcess = true;
    if (!(await DataConnectionChecker().hasConnection)) {
      purchaseResult = PurchaseResultFailed('noConnection');
      purchaseProcess = false;
      return;
    }
    final result = await _usecaseBuyProduct(product);
    result.fold((PurchaseResultFailed failed) {
      purchaseResult = failed;
    }, (PurchaseResultSuccess success) {
      purchaseResult = success;
      customer = success.customer;
      _appController.user = success.customer;
    });
    purchaseProcess = false;
  }
}
