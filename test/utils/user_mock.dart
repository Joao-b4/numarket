import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';

final userMock = User(
    id: "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
    name: "Jerry Smith",
    balance: 1000000,
    offers: [
      Product(
          name: "Portal Gun",
          id: "product/portal-gun",
          offerId: "offer/portal-gun",
          description: "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
          image: "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310",
          price: 5000)
    ]);

const ResultGetUserMock = {"viewer": {
  "name": "Jerry Smith",
  "balance": 1000000,
  "id": "cccc3f48-dd2c-43ba-b8de-8945e7ababab",
  "offers": [
    {
      "id": "offer/portal-gun",
      "price": 5000,
      "product": {
        "id": "product/portal-gun",
        "name": "Portal Gun",
        "description": "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
        "image": "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310"
      }
    }
  ]
}};
