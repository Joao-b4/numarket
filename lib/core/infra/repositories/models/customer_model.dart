import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';

class CustomerModel extends User {
  CustomerModel({id, name, balance, offers})
      : super(id: id, name: name, balance: balance, offers: offers);

  static CustomerModel fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      offers: OffersModel.fromMapColletion(map['offers'] as List ?? []),
    );
  }

}

class OffersModel extends Product {
  OffersModel({id, name, description, price, image, offerId})
      : super(
            id: id,
            name: name,
            description: description,
            price: price,
            image: image,
            offerId: offerId);

  static OffersModel fromMap(Map<String, dynamic> map) {
    return OffersModel(
      offerId: map['id'] as String,
      price: map['price'] as int,
      name: map['product']['name'] as String,
      id: map['product']['id'] as String,
      description: map['product']['description'] as String,
      image: map['product']['image'] as String,
    );
  }

  static List<OffersModel> fromMapColletion(List colletion) {
    return colletion.map((map) => OffersModel.fromMap(map as Map)).toList();
  }

}
