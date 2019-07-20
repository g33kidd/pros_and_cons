import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:pros_cons/util.dart';

const Set<String> _productIds = {'remove_ads_1'};

class AdFreeScreen extends StatefulWidget {
  @override
  _AdFreeScreenState createState() => _AdFreeScreenState();
}

class _AdFreeScreenState extends State<AdFreeScreen> {
  StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products;
  ProductDetails _removeAdsProduct;

  Future purchaseRemoveAds() async {
    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: _removeAdsProduct,
    );

    await InAppPurchaseConnection.instance.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  @override
  void initState() {
    final Stream purchaseUpdates =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdates.listen((purchases) {
      _handlePurchaseUpdates(purchases);
    });
    super.initState();
    connect();
  }

  Future connect() async {
    final bool available = await InAppPurchaseConnection.instance.isAvailable();
    if (!available) {
      print("Storefront available");
    }

    final ProductDetailsResponse response =
        await InAppPurchaseConnection.instance.queryProductDetails(_productIds);

    if (response.notFoundIDs.isNotEmpty) {
      print("IDs not found!");
    }

    _products = response.productDetails;
    _removeAdsProduct = _products.firstWhere((f) => f.id == 'remove_ads_1');
  }

  void _handlePurchaseUpdates(dynamic purchases) {
    print(purchases);
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(
      color: Colors.white,
      // fontSize: 22.0,
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: purple,
        title: Text("REMOVE ADS", style: _titleStyle),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: StreamBuilder(
          stream: InAppPurchaseConnection.instance.purchaseUpdatedStream,
          builder: (context, AsyncSnapshot<List<PurchaseDetails>> snapshot) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!snapshot.hasData) ...buildRemoveAdsSection(),
                if (snapshot.hasData && snapshot.data.isNotEmpty)
                  ...buildAlreadySupporting(),
                SizedBox(height: 20),
                Text(
                  "More support options coming in the future.",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> buildRemoveAdsSection() {
    return [
      Icon(
        Icons.block,
        size: 150.0,
        color: red,
      ),
      SizedBox(height: 16.0),
      FittedBox(
        child: Text(
          "REMOVE ADS",
          style: TextStyle(
            fontSize: 28.0,
            color: red,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      SizedBox(height: 18.0),
      Text(
        "Enjoying the app and want to help support development? By purchasing this package you will no longer receive ads!",
        textAlign: TextAlign.center,
        style: TextStyle(
          height: 1.3,
          fontSize: 18.0,
          color: Colors.blueGrey[700],
        ),
      ),
      SizedBox(height: 20.0),
      Text(
        "\$2.34 + tax",
        style: TextStyle(
          fontSize: 32.0,
          color: green,
          fontWeight: FontWeight.w800,
        ),
      ),
      SizedBox(height: 20.0),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTap: () async => await purchaseRemoveAds(),
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.pinkAccent,
            ),
            child: Center(
              child: Text(
                "PURCHASE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ),
    ];
  }

  List<Widget> buildAlreadySupporting() {
    return [
      Text(
        "🙌",
        style: TextStyle(
          fontSize: 73,
        ),
      ),
      SizedBox(height: 18.0),
      Text(
        "Thanks for purchasing!\nYou're already supporting me!\nAds are now removed!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22.0,
          height: 1.3,
        ),
      )
    ];
  }
}
