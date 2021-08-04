import 'package:numarket/core/domain/entities/product.dart';
import 'package:numarket/core/domain/entities/user.dart';
class CustomerModel extends User{
  final String id;
  final String name;
  final int balance;
  final List<Product> offers;

  CustomerModel({this.id, this.name, this.balance, this.offers});

  static CustomerModel fromMap(Map<String, dynamic> map) {
     return CustomerModel(
      id: map['id'],
      name: map['name'] ,
      balance: map['balance'] ,
      offers: OffersModel.fromMapColletion(map['offers'] as List ?? []),
    );
  }
}

class OffersModel extends Product{
  final String id;
  final String name;
  final String description;
  final int price;
  final String image;
  final String offerId;

  OffersModel({this.id, this.name, this.description, this.price, this.image, this.offerId});

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