import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/helper/const.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce_app/screen/place_order_page.dart';

class OrderListBloc {


  final _OrderListFetcher = BehaviorSubject<dynamic>();

  Observable<dynamic> get allOrders => _OrderListFetcher.stream;

  /*
  * Fetch the Orders list filtering by search text
  */

  onSearchTextChanged(String text) async {
    fetchOrders(text);
  }

  fetchOrders(String search) async {
    var response = await Const.wc_api.getAsync("orders?search=" + search);
    _OrderListFetcher.sink.add(response);
  }

  routeToNewOrderPage(BuildContext context) {
    Navigator.push(context,
            MaterialPageRoute(builder: (context) => PlaceOrderPage(null)))
        .then((onValue) {
      fetchOrders('');
    });
  }

  dispose() {
    _OrderListFetcher.close();
  }
}
