import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/helper/const.dart';
import 'package:rxdart/rxdart.dart';
import 'package:woocommerce_app/model/ordered_product.dart';
import 'package:woocommerce_app/screen/customer_add.dart';
import 'package:woocommerce_app/helper/ui_helper.dart';

class CartListBloc {
  List<OrderProducts> cartProductList = new List<OrderProducts>();

  Map<String, dynamic> customer = new Map<String, dynamic>();

  final _cartProductListFetcher = BehaviorSubject<dynamic>();

  final customerFetcher = BehaviorSubject<dynamic>();

  final totalCreditValueFetcher = BehaviorSubject<dynamic>();

  Observable<dynamic> get allCartProducts => _cartProductListFetcher.stream;

  CartListBloc(dynamic value, var customer) {
    this.cartProductList = value;
    this.customer = customer;
  }

  fetchCustomer() {
    customerFetcher.sink.add(customer);
  }

  /*
  * This function calculate total credit value from order items
  * Sink the the value 
  */

  fetchTotalCreditValue() {
    double totalCreditValue = 0.0;
    for (int i = 0; i < cartProductList.length; i++) {
      if (cartProductList[i].totalCreditValue != null)
        totalCreditValue =
            totalCreditValue + cartProductList[i].totalCreditValue;
    }
    totalCreditValueFetcher.sink.add(totalCreditValue);
  }

  fetchOrderedProducts() async {
    _cartProductListFetcher.sink.add(cartProductList);
  }

  Future createOrder(final _scaffoldKey, BuildContext context, Map paymentInfo) async {


    if (cartProductList.length > 0) { // Check the cart list empty or not

      if (customer != null) {  // Before place order check customer is available or not

        UIHelper.showProcessingDialog(context);  // Show a progress dialog during Place order http request

        List<dynamic> orderedProductList = new List<dynamic>(); // Prepare a product list which will be added in place order list

        for (int i = 0; i < cartProductList.length; i++) {
          Map<String, dynamic> addcartProductList = new Map<String, dynamic>();
          addcartProductList.putIfAbsent(
              'product_id', () => int.parse(cartProductList[i].id));
          addcartProductList.putIfAbsent(
              'quantity', () => cartProductList[i].orderCount);
          orderedProductList.add(addcartProductList);
        }

        try {
          var response = await Const.wc_api.postAsync("orders", {
            "payment_method": paymentInfo['payment_method'],
            "payment_method_title": paymentInfo['payment_method_title'],
            "set_paid": true,
            "billing": customer['billing'],
            "shipping": customer['shipping'],
            "line_items": orderedProductList,
          });

          Navigator.of(context).pop(); // Processing dialog close after getting the response

          if (response.containsKey('message')) //if response contains message key that means customer not created and return the reason in message key
          {
            showDefaultSnackbar(_scaffoldKey, context, response['message']);
          }
          else if (response.toString().contains('id'))  // if response contains id that customer created
          {
            showDefaultSnackbar(_scaffoldKey, context,
                'Congratulation ! Successfully place your order');
          }
          else
            {
              showDefaultSnackbar(_scaffoldKey, context, response.toString());
            }

        } catch (e) {

        }
      }
      else
      {
        showDefaultSnackbar(_scaffoldKey, context, 'Please ! add a customer');
      }
    }
    else
    {
      showDefaultSnackbar(
          _scaffoldKey, context, 'Please ! at least add one order');
    }
  }

  /*
  * This function add product count in cart by productId
  * Update the cart product list by sink to cartProductList
  * Also calculate cart product credit value
  */

  orderAdd(String productId) {
    for (int i = 0; i < cartProductList.length; i++) {
      if (productId == cartProductList[i].id) {
        int count = cartProductList[i].orderCount + 1;
        cartProductList[i].orderCount = count;
        if (cartProductList[i].mrp != null)
          cartProductList[i].totalCreditValue =
              double.parse(cartProductList[i].mrp) * count;
        break;
      }
    }
    _cartProductListFetcher.sink.add(cartProductList);
    fetchTotalCreditValue();
  }

  /*
  * This function remove product count in cart by productId
  * Update the cart product list by sink to cartProductList
  * Also calculate cart product credit value
  */

  orderRemove(String id) {
    for (int i = 0; i < cartProductList.length; i++) {
      if (id == cartProductList[i].id) {
        if (cartProductList[i].orderCount > 0) {
          int count = cartProductList[i].orderCount - 1;
          cartProductList[i].orderCount = count;
          if (cartProductList[i].mrp != null)
            cartProductList[i].totalCreditValue =
                double.parse(cartProductList[i].mrp) * count;

          break;
        }
      }
    }

    _cartProductListFetcher.sink.add(cartProductList);
    fetchTotalCreditValue();
  }

  /*
  * Function Remove product by productId from cart
  */

  orderDelete(String productId) {
    for (int i = 0; i < cartProductList.length; i++) {
      cartProductList.removeAt(i);
    }

    _cartProductListFetcher.sink.add(cartProductList);
    fetchTotalCreditValue();
  }

  /*
    Function Route to new customer page if customer not available during place order
  */

  routeToCustomerAddPage(BuildContext context) {
    Navigator.push(
            context, MaterialPageRoute(builder: (context) => CustomerAddPage()))
        .then((onValue) {
      if (onValue != null) {
        this.customer = onValue;
        fetchCustomer();
      }
    });
  }

  dispose() {
    _cartProductListFetcher.close();
  }


  /*
    Function Display proper message to user after requesting to create a order
  */

  void showDefaultSnackbar(
      final _scaffoldKey, BuildContext context, String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(minutes: 5),
        content: Text(message),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Ok',
          onPressed: () {
            if (!message.contains('customer'))
              Navigator.of(context).pop(customer); // Back to customer list page
          },
        ),
      ),
    );
  }
}
