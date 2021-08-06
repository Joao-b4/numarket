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
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ProductControllerBase.loading'))
      .value;

  final _$customerAtom = Atom(name: '_ProductControllerBase.customer');

  @override
  User get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(User value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  final _$productAtom = Atom(name: '_ProductControllerBase.product');

  @override
  Product get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(Product value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
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

  final _$errorAtom = Atom(name: '_ProductControllerBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
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
  dynamic loadOffer({String productId}) {
    final _$actionInfo = _$_ProductControllerBaseActionController.startAction(
        name: '_ProductControllerBase.loadOffer');
    try {
      return super.loadOffer(productId: productId);
    } finally {
      _$_ProductControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
customer: ${customer},
product: ${product},
purchaseResult: ${purchaseResult},
purchaseProcess: ${purchaseProcess},
error: ${error},
loading: ${loading}
    ''';
  }
}
