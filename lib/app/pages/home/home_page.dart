import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:numarket/app/app_controller.dart';
import 'package:numarket/app/app_module.dart';
import 'package:numarket/core/domain/entities/product.dart';

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
        backgroundColor: Colors.deepPurple,
        body: Observer(
          builder: (_) {
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
                        IconButton(icon: Icon(_obscureBalance ? Icons.visibility_off : Icons.visibility, color: Colors.white, ), onPressed: (){
                          setState(() {
                            _obscureBalance = !_obscureBalance;
                          });
                        }),
                        Text("R\$ ${_obscureBalance ? "" : controller.user.balance }",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        )
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
                      shrinkWrap: true,
                      itemCount: controller.user.offers.length,
                      itemBuilder: (BuildContext context, int productIndex) =>
                          wProductTile(controller.user.offers[productIndex]),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget wProductTile(Product currentProduct) {
    return ListTile(
      onTap: () {
        Modular.to.pushNamed("/product", arguments: currentProduct.id);
      },
      title: Text(currentProduct.name),
      leading: Image.network(
        currentProduct.image,
        width: 40,
        height: 40,
      ),
      subtitle: Text("R\$ ${currentProduct.price}"),
    );
  }
}
