import 'package:flutter/material.dart';
import 'package:numarket/app/config/AppLocalizations.dart';

class BuyButton extends StatelessWidget {
  final Function onPressed;

  const BuyButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.purple,
      elevation: 3,
      textColor: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart,
            size: 25,
          ),
          Text(
            AppLocalizations.of(context).translate('buy'),
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }
}
