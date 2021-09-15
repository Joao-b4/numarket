import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/config/AppLocalizations.dart';
import 'package:numarket/app/pages/home/components/product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, AppController> {
  bool _obscureBalance;

  @override
  void initState() {
    super.initState();
    _obscureBalance = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Observer(
          builder: (_) {
            if(controller.error != null){
              return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(controller.error,style: TextStyle(
                          color: Colors.white
                      ),),
                      RaisedButton(
                        child: Text(AppLocalizations.of(context).translate('tryAgain')),
                        onPressed: (){
                          controller.loadUser();
                        },
                      )
                    ],
                  )
              );
            }

            if (controller.loading) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));
            }
            return Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img/nubank-logo.png',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.contain,
                        height: 50,
                        width: 60,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        controller.user.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              _obscureBalance
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureBalance = !_obscureBalance;
                              });
                            }),
                        Text(
                          "${AppLocalizations.of(context).translate('moneySign')} ${_obscureBalance ? "" : controller.user.balance}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.redo,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              controller.loadUser();
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.user.offers.length,
                      itemBuilder: (BuildContext context, int productIndex) =>
                          ProductTile(
                        product: controller.user.offers[productIndex],
                        onTap: () => Modular.to.pushNamed("/product",
                            arguments: controller.user.offers[productIndex].id),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
