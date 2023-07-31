import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_hud/progress_hud.dart';


class UIHelper{


  static const bool isFill = true;

  static const double margin = 15;

  static double navigateIconSize = 35;

  static const double detailsMargin = 10;

  static Color addFormContainerBodyColor =  Color.fromRGBO(240,240,240,100);
  static Color themeColor  = Colors.red;


  static showToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static UnderlineInputBorder borderWeight()
  {

    UnderlineInputBorder(
      borderSide: BorderSide(width: 0.5),
    );
  }



  static TextStyle getTextStyleForHomeScreenItem()
  {

    return new TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 12
    );

  }


  static showProcessingDialog(BuildContext _context) {

    ProgressHUD _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: UIHelper.themeColor,
      borderRadius: 5.0,
      text: 'Processing...',
    );
    showDialog(
      context: _context,
      builder: (_context) {
        // return object of type Dialog
        return _progressHUD;
      },
    );
  }




}