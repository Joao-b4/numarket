import 'package:numarket/core/domain/entities/product.dart';
class User{
  final String id;
  final String name;
  final int balance;
  final List<Product> offers;

  User({this.id, this.name, this.balance, this.offers});
}