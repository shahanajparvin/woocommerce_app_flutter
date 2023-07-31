import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/customer_list_bloc.dart';
import 'package:woocommerce_app/bloc/order_list_bloc.dart';
import 'package:woocommerce_app/helper/const.dart';

class OrderListPage extends StatefulWidget {
  @override
  OrderListPageState createState() => new OrderListPageState();
}

class OrderListPageState extends State<OrderListPage> {


  Widget _mainFormWidget;

  var bloc;

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    bloc = OrderListBloc();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    if (_mainFormWidget == null) {
      _mainFormWidget = mainBody();
    }
    return _mainFormWidget; // Show the form in the application
  }

  Widget mainBody() {
    return new Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bloc.routeToNewOrderPage(_context);
          },
          child: Icon(
            Icons.note_add,
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: new Text("Orders", style: TextStyle(color: Colors.white)),
        ),
        body: body());
  }

  Widget body() {
    return new Column(children: <Widget>[

      // Search Box Widget

      Container(
        height: 50,
        child: new Card(
            child: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              // controller: controller,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 20.0, 15.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: '  Search',
                  border: InputBorder.none),
              onChanged: bloc.onSearchTextChanged,
            )),
          ],
        )),
      ),



      ordersListBuild()  // Orders List Widget
    ]);
  }

  /*
  * Function perform a http request using BLoc for all orders list
  * Return a list widget using Stream builder
  */

  Widget ordersListBuild() {
    bloc.fetchOrders('');
    return StreamBuilder(
      stream: bloc.allOrders,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? ordersListViewWidget(snapshot)
            : Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
      },
    );
  }

  /*
  * Function takes AsyncSnapshot data for build a ListView
  * Function return a ListView widget
  */

  Widget ordersListViewWidget(AsyncSnapshot<dynamic> s) {
    return new Expanded(
        child: ListView.builder(
            itemCount: s.data.length,
            itemBuilder: (_, index) {
              return InkWell(
                  /*onTap: () {
                    bloc.routeToPlaceOrderPage(_context, s.data[index]);
                  },*/
                  child: Container(
                      margin: EdgeInsets.all(6),
                      child: Card(
                          child: Column(
                        children: <Widget>[
                          ListTile(
                            trailing: statusBox(s.data[index]['status']),
                            leading: new Container(
                                child: new Center(
                                  child: Text(
                                    "#" + s.data[index]["id"].toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                width: 40.0,
                                height: 40.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red)),
                            title: Text(s.data[index]['billing']["email"],
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey)),
                            subtitle: Text(
                                s.data[index]["date_created"]
                                        .toString()
                                        .substring(0, 10) +
                                    "  ||  " +
                                    s.data[index]["currency"].toString() +
                                    " " +
                                    s.data[index]["total"].toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                        ],
                      ))));
            }));
  }

  /*
  * Function take order status input
  * Build a orders status and background color according to the status
  * */

  Widget statusBox(String orderStatus) {
    Color bgColor = Colors.blueAccent;

    if (orderStatus == 'processing') {
      bgColor = Colors.blue;
    } else if (orderStatus == 'completed') {
      bgColor = Colors.green;
    } else if (orderStatus == 'on-hold') {
      bgColor = Colors.orange;
    }

    return Container(
        width: 70,
        height: 30,
        child: Center(
            child: Text(orderStatus,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.white))),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(3)));
  }
}
