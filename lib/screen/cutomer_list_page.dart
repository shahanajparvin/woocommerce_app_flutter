import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/customer_list_bloc.dart';
import 'package:woocommerce_app/helper/const.dart';

class CustomerListPage extends StatefulWidget {
  @override
  CustomerListPageState createState() => new CustomerListPageState();
}

class CustomerListPageState extends State<CustomerListPage> {
  Widget _mainFormWidget; // Save the form

  var bloc; // Associate bloc

  BuildContext _context;

  @override
  void initState() {
    super.initState();
    bloc = CustomerListBloc();
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
            bloc.routeToCustomerAddPage(_context);
          },
          child: Icon(Icons.people),
          backgroundColor: Colors.green,
        ),
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: new Text("Customers", style: TextStyle(color: Colors.white)),
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

      // Customer List Widget

      customerListBuild()
    ]);
  }

  /*
  * Function perform a http request using BLoc for all customer list
  * Return a list widget using Stream builder 
  */

  Widget customerListBuild() {
    bloc.fetchCustomers('');
    return StreamBuilder(
      stream: bloc.allCustomers,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? customerListViewWidget(snapshot)
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

  Widget customerListViewWidget(AsyncSnapshot<dynamic> snapshot) {
    return new Expanded(
        child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) {
              return InkWell(
                  onTap: () {
                    bloc.routeToPlaceOrderPage(_context, snapshot.data[index]);
                  },
                  child: Container(
                      margin: EdgeInsets.all(6),
                      child: Card(
                          child: Column(
                        children: <Widget>[
                          ListTile(
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                                onPressed: () {
                                  bloc.routeToPlaceOrderPage(
                                      _context, snapshot.data[index]);
                                }),
                            leading: new Container(
                                child: new Center(
                                  child: Text(
                                    snapshot.data[index]["email"].substring(0, 1),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                width: 40.0,
                                height: 40.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red)),
                            title: Text(snapshot.data[index]["email"],
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            subtitle: Text(
                                snapshot.data[index]["shipping"]["address_1"]
                                    .toString(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey)),
                          ),
                        ],
                      ))));
            }));
  }
}
