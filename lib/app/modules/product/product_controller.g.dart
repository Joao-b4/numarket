// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProductController = BindInject(
  (i) => ProductController(i<IBuyProduct>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductController on _ProductControllerBase, Store {
  Computed<Product> _$productComputed;

  @override
  Product get product =>
      (_$productComputed ??= Computed<Product>(() => super.product,
              name: '_ProductControllerBase.product'))
          .value;
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ProductControllerBase.loading'))
      .value;

  final _$_customerAtom = Atom(name: '_ProductControllerBase._customer');

  @override
  User get _customer {
    _$_customerAtom.reportRead();
    return super._customer;
  }

  @override
  set _customer(User value) {
    _$_customerAtom.reportWrite(value, super._customer, () {
      super._customer = value;
    });
  }

  final _$productIdAtom = Atom(name: '_ProductControllerBase.productId');

  @override
  String get productId {
    _$productIdAtom.reportRead();
    return super.productId;
  }

  @override
  set productId(String value) {
    _$productIdAtom.reportWrite(value, super.productId, () {
      super.productId = value;
    });
  }

  final _$purchaseResultAtom =
      Atom(name: '_ProductControllerBase.purchaseResult');

  @override
  PurchaseResult get purchaseResult {
    _$purchaseResultAtom.reportRead();
    return super.purchaseResult;
  }

  @override
  set purchaseResult(PurchaseResult value) {
    _$purchaseResultAtom.reportWrite(value, super.purchaseResult, () {
      super.purchaseResult = value;
    });
  }

  final _$purchaseProcessAtom =
      Atom(name: '_ProductControllerBase.purchaseProcess');

  @override
  bool get purchaseProcess {
    _$purchaseProcessAtom.reportRead();
    return super.purchaseProcess;
  }

  @override
  set purchaseProcess(bool value) {
    _$purchaseProcessAtom.reportWrite(value, super.purchaseProcess, () {
      super.purchaseProcess = value;
    });
  }

  final _$buyAsyncAction = AsyncAction('_ProductControllerBase.buy');

  @override
  Future buy() {
    return _$buyAsyncAction.run(() => super.buy());
  }

  final _$_ProductControllerBaseActionController =
      ActionController(name: '_ProductControllerBase');

  @override
  dynamic loadOffer({User customer, String productId}) {
    final _$actionInfo = _$_ProductControllerBaseActionController.startAction(
        name: '_ProductControllerBase.loadOffer');
    try {
      return super.loadOffer(customer: customer, productId: productId);
    } finally {
      _$_ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productId: ${productId},
purchaseResult: ${purchaseResult},
purchaseProcess: ${purchaseProcess},
product: ${product},
loading: ${loading}
    ''';
  }
}
