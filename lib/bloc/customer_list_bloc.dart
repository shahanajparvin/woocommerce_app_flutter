import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/helper/const.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce_app/screen/customer_add.dart';
import 'package:woocommerce_app/screen/place_order_page.dart';

class CustomerListBloc {
  final _customerListFetcher = BehaviorSubject<dynamic>();

  Observable<dynamic> get allCustomers => _customerListFetcher.stream;

  /*
  * Fetch the customer list filtering by search text
  */

  onSearchTextChanged(String searchText) async {

    fetchCustomers(searchText);

  }

  fetchCustomers(String search) async {

    var response = await Const.wc_api.getAsync("customers?search=" + search);
    _customerListFetcher.sink.add(response);

  }

  routeToPlaceOrderPage(BuildContext context, var customer) {

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PlaceOrderPage(customer)));

  }

  routeToCustomerAddPage(BuildContext context) {

    Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomerAddPage()))
        .then((onValue) {

             // After return the page refresh the customer list by http request to add the new order in list

              if (onValue != null) {
                fetchCustomers('');
              }

    });
  }

  dispose() {

    _customerListFetcher.close();

  }
}
