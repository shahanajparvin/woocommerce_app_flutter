import 'dart:async';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/helper/const.dart';
import 'package:woocommerce_app/helper/ui_helper.dart';

class CustomerAddBloc {


  Future createCustomer(Map customerBasicInfo, Map customerAddressInfo, final _scaffoldKey, BuildContext context) async {

    UIHelper.showProcessingDialog(context);   // Show a progress dialog during network request

    try {
      var response = await Const.wc_api.postAsync("customers", {
        "email": customerBasicInfo['email'],
        "first_name": customerBasicInfo['firstName'],
        "username": customerBasicInfo['userName'],
        "billing": customerAddressInfo,
        "shipping": customerAddressInfo
      });


      Navigator.of(context).pop(); // Processing dialog close after getting the response

      if (response.containsKey('message')) // if response contains message key that means customer not created and return the reason in message key
      {

        showSnackbarWithProperMessage(
            _scaffoldKey, context, response['message']);

      } else if (response.toString().contains('id'))  // if response contains id that customer created
      {

        showSnackbarWithProperMessage(_scaffoldKey, context,
            'Congratulation ! Successfully place your order');


        Navigator.of(context).pop(response); // Back to customer list page

      } else
        {
          showSnackbarWithProperMessage(_scaffoldKey, context,
              response.toString()); // JSON Object with response

        }

    } catch (e) {
    }
  }

  /*
    Function Display proper message to user after requesting to create a customer
  */

  void showSnackbarWithProperMessage(final _scaffoldKey, BuildContext context, String disPlayMessage) {

          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(minutes: 5),
              content: Text(disPlayMessage),
            ),
          );

    }
}
