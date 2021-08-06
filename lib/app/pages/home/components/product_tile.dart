import 'package:flutter/material.dart';
import 'package:numarket/app/config/AppLocalizations.dart';
import 'package:numarket/core/domain/entities/product.dart';

class ProductTile extends StatelessWidget {
  final Function onTap;
  final Product product;

  const ProductTile({Key key, this.onTap, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(product.name),
      leading: Image.network(
        product.image,
        width: 40,
        height: 40,
      ),
      subtitle: Text("${AppLocalizations.of(context).translate('moneySign')} ${product.price}"),
    );
  }
}
