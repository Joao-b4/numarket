import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  final String id;
  const ProductPage({Key key, this.id}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  AppController _appController;
  final List<ReactionDisposer> _disposers = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _appController = AppModule.to.get<AppController>();
    controller.loadOffer(customer: _appController.user, productId: widget.id);
  }

  @override
  void dispose(){
    _disposers.forEach((disposer) => disposer());
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _disposers.add(
      reaction(
            (_) => controller.purchaseResult,
            (_)  {
              if(controller.purchaseResult is PurchaseResultFailed){
                PurchaseResultFailed purchaseResultFailed = controller.purchaseResult;
                _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(purchaseResultFailed.message),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 3),
                    ));
              }else if (controller.purchaseResult is PurchaseResultSuccess){
                PurchaseResultSuccess purchaseResultSuccess = controller.purchaseResult;
                _appController.user = purchaseResultSuccess.customer;
                return Navigator.of(context).pop();
              }
            },
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Observer(builder: (_) => Text("${controller.product.name}")),
      ),
      body: Observer(
        builder: (_) {
          if (controller.loading) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ));
          }

          return Stack(
            children: [
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Image.network(
                          controller.product.image,
                          width: MediaQuery.of(context).size.width,
                        )),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          controller.product.name,
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          controller.product.description,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20),
                child: RaisedButton(
                  onPressed: controller.purchaseProcess ? null : () {
                    controller.buy();
                  },
                  color: Colors.purple,
                  elevation: 3,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, size: 25,),
                      Text("Comprar",style: TextStyle(fontSize: 17),)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
