import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';
import 'package:numarket/core/domain/usecases/buy_product.dart';

final purchaseResultSuccessMock = PurchaseResultSuccess(User(
    id: "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
    name: "Jerry Smith",
    balance: 995000,
    offers: [
      Product(
          name: "Portal Gun",
          id: "product/portal-gun",
          offerId: "offer/portal-gun",
          description:
              "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
          image:
              "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310",
          price: 5000)
    ]));

final purchaseResultFailedMock = PurchaseResultFailed("500");

const PurchaseResultFailedFromGraphqlMock  = {
  "purchase": {
    "success": false,
    "errorMessage": "You don't have that much money.",
    "customer": {
      "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      "name": "Jerry Smith",
      "balance": 1000000
    }
  }
};

const PurchaseResultSuccessFromGraphqlMock = {
  "purchase": {
    "success": true,
    "errorMessage": null,
    "customer": {
      "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
      "name": "Jerry Smith",
      "balance": 995000
    }
  }
};