import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:numarket/app/config/AppLocalizations.dart';
import 'package:numarket/app/modules/product/components/buy_button.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';
import 'product_controller.dart';

class ProductPage extends StatefulWidget {
  final String id;
  const ProductPage({Key key, this.id}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends ModularState<ProductPage, ProductController> {
  final List<ReactionDisposer> _disposers = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller.loadOffer(productId: widget.id);
  }

  @override
  void dispose() {
    _disposers.forEach((disposer) => disposer());
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
      reaction(
        (_) => controller.purchaseResult,
        (_) {
          if (controller.purchaseResult is PurchaseResultFailed) {
            showPurchaseFailed(controller.purchaseResult);
            return;
          }
          if (controller.purchaseResult is PurchaseResultSuccess) {
            showPurchaseSuccess();
            Future.delayed(
                Duration(seconds: 2), () => Navigator.of(context).pop());
            return;
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
        title: Observer(builder: (_) => Text("${controller.product?.name ?? "" }")),
      ),
      body: Observer(
        builder: (_) {
          if (controller.error != null) {
            return Center(
              child: Text(
                controller.error,
                style: TextStyle(color: Colors.purple),
              ),
            );
          }

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
                margin: EdgeInsets.only(bottom: 35),
                child: BuyButton(
                    onPressed: controller.purchaseProcess
                        ? null
                        : () => controller.buy()),
              )
            ],
          );
        },
      ),
    );
  }

  void showPurchaseFailed(PurchaseResultFailed purchaseResult) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).translate(purchaseResult.message) ?? AppLocalizations.of(context).translate('purchaseNotMade') ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }

  void showPurchaseSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(AppLocalizations.of(context).translate('purchaseSuccess')),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 2),
    ));
  }
}
