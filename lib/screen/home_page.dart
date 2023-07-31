import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/home_page_bloc.dart';
import 'package:woocommerce_app/helper/const.dart';
import 'package:woocommerce_app/helper/hex_color.dart';
import 'package:woocommerce_app/screen/cutomer_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:woocommerce_app/screen/my_profile_page.dart';
import 'package:woocommerce_app/screen/order_list_page.dart';
import 'package:woocommerce_app/screen/place_order_page.dart';
import 'package:woocommerce_app/helper/ui_helper.dart';


class HomePage extends StatefulWidget {
  @override
  HomePagePageState createState() => new HomePagePageState();
}

class HomePagePageState extends State<HomePage> {

  var bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomePageBloc();

    // Function call for sales status report
    bloc.fetchSalesReports();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: new Text("Woocom Admin", style: TextStyle(color: Colors.white)),
        ),
        persistentFooterButtons: <Widget>[
          Text('Version 1.0.0'),
        ],
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40.0,
                      child: Image.asset('images/woocom_icon.jpg'),
                    ),
                    SizedBox(height: 20,),
                    Text("Welcome to Woocom Admin",
                      style: TextStyle(color: Colors.white),),
                    SizedBox(height: 10,),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),

              ListTile(
                leading: Icon(Icons.library_add),
                title: Text('New Order'),
                onTap: () {

                  // Route to Order Add Page

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlaceOrderPage(null)));
                  //   Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.border_all),
                title: Text('My Order'),
                onTap: () {

                  // Route to Order List Page

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OrderListPage()));

                },
              ),

              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('My Profile'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserProfilePage()));
                  //   Navigator.pop(context);
                },
              ),


            ],
          ),
        ),
        body: new Container(

            color: HexColor("#FFF8F8"),

            child: Column(

              children: <Widget>[


                Container(

                    color: Colors.transparent,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.35,


                    child: Row(


                      children: <Widget>[

                        Expanded(

                            child: Container(

                              margin: EdgeInsets.only(
                                  left: 20, top: 30, bottom: 30, right: 15),


                              child: InkWell(
                                  onTap: () {

                                    // Route to Customer List Page

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomerListPage()));
                                  },
                                  child: Card(

                                    child: Center(


                                        child: Column(

                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            mainAxisSize: MainAxisSize.max,

                                            children: <Widget>[

                                              Icon(
                                                Icons.people,
                                                color: UIHelper.themeColor,
                                                size: 40,
                                              ),

                                              Container(height: 10,),

                                              Text('Customers',style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                   fontSize: 14
                                                  ))

                                            ]

                                        )


                                    ),
                                  )),
                            )


                        ),

                        Expanded(

                            child: Container(

                              margin: EdgeInsets.only(
                                  left: 15, top: 30, bottom: 30, right: 20),


                              child: InkWell(
                                  onTap: () {

                                    // Route to Order List Page

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderListPage()));
                                  },
                                  child: Card(

                                    child: Center(


                                        child: Column(

                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            mainAxisSize: MainAxisSize.max,

                                            children: <Widget>[

                                              Icon(
                                                Icons.assignment,
                                                color: UIHelper.themeColor,
                                                size: 40,
                                              ),

                                              Container(height: 10,),

                                              Text('Orders',style: TextStyle(
                                              color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14
                                              ))

                                            ]

                                        )


                                    ),
                                  )),
                            )


                        )


                      ],


                    )

                ),

                Container(


                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.45,

                    child: Container(


                        margin: EdgeInsets.all(20.0),

                        child: Card(


                          elevation: 2,
                          child: ClipPath(

                              clipper: ShapeBorderClipper(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3))),

                              child: Container(

                                  decoration: BoxDecoration(
                                      border: Border(top: BorderSide(
                                          color: Colors.red, width: 5))),

                                  child: Container(


                                      margin: EdgeInsets.all(20.0),

                                      child:

                                      Column(

                                        children: <Widget>[


                                          Flexible(

                                              flex: 5,

                                              child: new Row(

                                                  children: <Widget>[


                                                    Flexible(

                                                        flex: 3,
                                                        child: new Center(

                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  totalCountPerModuleWidget(
                                                                      'customers'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text(
                                                                    'Customer',
                                                                     style: UIHelper.getTextStyleForHomeScreenItem(),)

                                                                ]

                                                            )

                                                        )),


                                                    new Container(
                                                      color: Colors.grey,
                                                      width: .5, height: 40,),

                                                    Flexible(

                                                        flex: 3,
                                                        child: new Container(

                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  totalCountPerModuleWidget(
                                                                      'products'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text(
                                                                    'Products',
                                                                    style: UIHelper.getTextStyleForHomeScreenItem())

                                                                ]

                                                            )

                                                        )),

                                                    new Container(
                                                      color: Colors.grey,
                                                      width: .5, height: 40,),
                                                    Flexible(

                                                        flex: 3,
                                                        child: new Container(
                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  totalCountPerModuleWidget(
                                                                      'orders'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text('Orders',
                                                                    style: UIHelper.getTextStyleForHomeScreenItem(),)

                                                                ]

                                                            ))),


                                                  ]
                                              )),


                                          new Container(
                                            height: .5, color: Colors.grey,),


                                          Flexible(

                                              flex: 5,

                                              child: new Row(

                                                  children: <Widget>[


                                                    Flexible(

                                                        flex: 3,
                                                        child: new Center(

                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  salesValueReportBySalesType('average'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text(
                                                                    'Avg sales',
                                                                    style: UIHelper.getTextStyleForHomeScreenItem())

                                                                ]

                                                            )

                                                        )),


                                                    new Container(
                                                      color: Colors.grey,
                                                      width: .5, height: 40,),

                                                    Flexible(

                                                        flex: 3,
                                                        child: new Container(

                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  salesValueReportBySalesType('net'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text(
                                                                    'Net sales',
                                                                    style: UIHelper.getTextStyleForHomeScreenItem())

                                                                ]

                                                            )

                                                        )),

                                                    new Container(
                                                      color: Colors.grey,
                                                      width: .5, height: 40,),
                                                    Flexible(

                                                        flex: 3,
                                                        child: new Container(
                                                            child: Column(

                                                                mainAxisAlignment: MainAxisAlignment
                                                                    .center,
                                                                mainAxisSize: MainAxisSize
                                                                    .max,

                                                                children: <
                                                                    Widget>[

                                                                  salesValueReportBySalesType('total'),

                                                                  Container(
                                                                    height: 5,),

                                                                  Text(
                                                                    'Total sales',
                                                                    style: UIHelper.getTextStyleForHomeScreenItem())

                                                                ]

                                                            ))),


                                                  ]
                                              )),


                                        ],


                                      )


                                  ))),


                        )


                    )


                )
              ],

            )


        )
    );
  }

  /*
  * This function takes input module name
  * Perform a http request
  * return the total count of module
  * Set the count value in Text Widget
  * return a Widget
  */


  Widget totalCountPerModuleWidget(String moduleName ) {

    bloc.fetchPerModuleCount(moduleName);

    Stream stream ;

    if(moduleName=='customers')
    {
      stream = bloc.customerCountFetcher.stream;
    }
    else if(moduleName=='products')
    {
      stream = bloc.productCountFetcher.stream;
    }
    else if(moduleName=='orders')
    {
      stream = bloc.orderCountFetcher.stream;
    }


    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? new Container(
            child: Text(snapshot.data.toString(),style: TextStyle(color: UIHelper.themeColor,fontWeight: FontWeight.w600,fontSize: 14)))
            : new Container(
            height: 20,
            width: 20,
            child:CircularProgressIndicator(strokeWidth: 2,));
      },
    );
  }

  Widget salesValueReportBySalesType(String salesType ) {

    Stream stream ;

    if(salesType=='average')
    {
      stream = bloc.averageSalesValueFetcher.stream;
    }
    else if(salesType=='net')
    {
      stream = bloc.netSalesValueFetcher.stream;
    }
    else if(salesType=='total')
    {
      stream = bloc.totalSalesValueFetcher.stream;
    }

    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? new Container(
            child: Text('\$ '+snapshot.data.toString(),style: TextStyle(color: UIHelper.themeColor)))
            : new Container(
            height: 20,
            width: 20,
            child:CircularProgressIndicator(strokeWidth: 2,));
      },
    );
  }


}
