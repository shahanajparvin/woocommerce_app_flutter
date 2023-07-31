import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woocommerce_app/bloc/cart_page_bloc.dart';
import 'package:woocommerce_app/helper/hex_color.dart';
import 'package:woocommerce_app/helper/ui_helper.dart';
import 'package:woocommerce_app/model/ordered_product.dart';

class CartListPage extends StatefulWidget {
  List<OrderProducts> productList = new List<OrderProducts>();

  Map<String, dynamic> customer = new Map<String, dynamic>();

  CartListPage(this.productList, this.customer);

  @override
  CartListPageState createState() => new CartListPageState(this);
}

class CartListPageState extends State<CartListPage> {
  Widget _mainFormWidget;

  BuildContext _context;

  var bloc;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CartListPage parent;

  CartListPageState(this.parent);

  TextEditingController paymentMethodTitle = new TextEditingController();

  TextEditingController paymentMethod = new TextEditingController();

  Map<String, String> payMethodInformation = new Map<String, String>();

  @override
  void initState() {
    super.initState();
    bloc = CartListBloc(parent.productList, parent.customer);
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
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: new Container(
          height: 45,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Center(
                  child: totalCreditWidget(),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: InkWell(
                      onTap: () {
                        payMethodInformation['payment_method'] =
                            paymentMethod.text;
                        payMethodInformation['payment_method_title'] =
                            paymentMethodTitle.text;
                        bloc.createOrder(
                            _scaffoldKey, _context, payMethodInformation);
                      },
                      child: Container(
                          color: UIHelper.themeColor,
                          child: Center(
                            child: Text('Place Order',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white)),
                          ))))
            ],
          ),
        ),
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: new Text("Cart", style: TextStyle(color: Colors.white)),
        ),
        body: body());
  }

  Widget body() {
    return new Column(children: <Widget>[
      //UIHelper.searchBox(bloc,()=>searchForm()),

      headerDivWidget("Customer"),

      customerDetail(),

      Container(
        height: 0.5,
        width: MediaQuery.of(context).size.width * 1.0,
        color: Colors.grey,
      ),

      headerDivWidget("Item Details"),

      OrderedProductListBuild(),

      Container(
        height: 0.5,
        width: MediaQuery.of(context).size.width * 1.0,
        color: Colors.grey,
      ),


      Align(
          alignment: Alignment.bottomLeft,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              headerDivWidget("Payment Method"),
              Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(5.0),
                  child: TextField(
                    controller: paymentMethod,
                    decoration: new InputDecoration(
                      hintText: 'Please type payment method',
                      enabledBorder: UIHelper.borderWeight(),
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ))
            ],
          ))
    ]);
  }

  Widget headerDivWidget(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 1.0,
      //height: 40,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
          new Container(
            width: MediaQuery.of(context).size.width * 0.6,
          ),


          name.contains('Customer')
              ? addCustomer()
              : new Container()
        ],
      ),

      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.grey),
        ),
        color: HexColor("#FFF8F8"),
      ),
    );
  }

  /*
  * If customer not available during the place order this widget to available to add customer functionality
  * */

  Widget addCustomer() {
    return InkWell(
      onTap: () {
        bloc.routeToCustomerAddPage(_context);
      },
      child: Icon(Icons.add_circle, color: Colors.green),
    );
  }

  /*
  * Function request to the bloc for total ordered product credit and return a widget with total credit value
  */

  Widget totalCreditWidget() {
    bloc.fetchTotalCreditValue();
    return StreamBuilder(
      stream: bloc.totalCreditValueFetcher.stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Text(
                '\$ ' + snapshot.data.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: UIHelper.themeColor),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*
  * Function check customer is available or not for place a order
  * If available return a widget with customer information
  * If not available return a widget with waring message
  */

  Widget customerDetail() {
    bloc.fetchCustomer();
    return StreamBuilder(
      stream: bloc.customerFetcher.stream,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        //  print(' ttt '+ snapshot.data.toString());
        return snapshot.hasData
            ? customerDetailsView(snapshot)
            : Center(
                child: Card(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text('Please add a customer!'),
                        ))));
      },
    );
  }

  /*
  * Return a widget with customer details information
  */

  Widget customerDetailsView(AsyncSnapshot<dynamic> s) {
    return ListTile(
      leading: new Container(
          child: new Center(
            child: Text(
              s.data["email"].substring(0, 1),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          width: 40.0,
          height: 40.0,
          decoration:
              new BoxDecoration(shape: BoxShape.circle, color: Colors.red)),
      title: Text(s.data["email"]),
      subtitle: Text(s.data["shipping"]["address_1"].toString()),
    );
  }

  /*
  * Function request ordered product list using BLoc
  * Return a list widget using Stream builder
  */

  Widget OrderedProductListBuild() {
    bloc.fetchOrderedProducts();
    return StreamBuilder(
      stream: bloc.allCartProducts,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        //  print(' ttt '+ snapshot.data.toString());
        return snapshot.hasData
            ? orderedProductListViewWidget(snapshot)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  /*
  * Function takes AsyncSnapshot data for build a ListView
  * Function return a ListView widget
  */

  Widget orderedProductListViewWidget(AsyncSnapshot<dynamic> s) {
    return new Expanded(
        child: ListView.builder(
            itemCount: s.data.length,
            itemBuilder: (_, index) {
              OrderProducts product = s.data[index];

              String productImageUrl = product.imageUrl;

              if (productImageUrl != null &&
                  !productImageUrl.contains('woocommerce-placeholder')) {
                productImageUrl = product.imageUrl;
              } else {
                productImageUrl = null;
              }

              return Container(
                  margin: EdgeInsets.all(6),
                  child: Card(
                      child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: new Container(
                            child: productImageUrl != null
                                ? new Container()
                                : new Center(
                                    child: Text(
                                      product.name.substring(0, 1),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                            width: 40.0,
                            height: 40.0,
                            decoration: productImageUrl != null
                                ? new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            new NetworkImage(product.imageUrl)))
                                : new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: UIHelper.themeColor)),
                        title: Text(product.name),
                        subtitle: Text("MRP : " +
                            product.mrp.toString() +
                            "  |  " +
                            "Stock : " +
                            product.stock.toString()),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 30,
                          ),
                          IconButton(
                            onPressed: () {
                              bloc.orderDelete(product.id.toString());
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          new Flexible(
                              child: Container(
                            width: 60,
                            child: new Text(
                                '\$ ' + product.totalCreditValue.toString()),
                          )),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                    color: UIHelper.themeColor, width: 2)),
                            width: 122,
                            height: 40,
                            child: new Row(
                              children: <Widget>[
                                Container(
                                  width: 39,
                                  child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.remove,
                                              color: UIHelper.themeColor),
                                          onPressed: () {
                                            bloc.orderRemove(product.id);
                                          })),
                                ),
                                Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    product.orderCount.toString(),
                                    style:
                                        TextStyle(color: UIHelper.themeColor),
                                  )),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                          width: 1.0,
                                          color: UIHelper.themeColor),
                                      left: BorderSide(
                                          width: 1.0,
                                          color: UIHelper.themeColor),
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 39,
                                  child: Center(
                                      child: IconButton(
                                          icon: Icon(Icons.add,
                                              color: UIHelper.themeColor),
                                          onPressed: () {
                                            bloc.orderAdd(product.id);
                                          })),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  )));
            }));
  }
}
